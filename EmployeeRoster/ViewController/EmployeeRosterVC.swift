//
//  EmployeeRosterVC.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CocoaLumberjack
import EventStoreHelperRx

final class EmployeeRosterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView?

    @IBOutlet weak var buttonRefresh: UIBarButtonItem!
    private var viewModel: EmployeeViewModelProtocol!
    private var employeeList: EmployeeModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.viewModelSetUp()
    }

    private func setupUI() {
        self.navigationItem.title = "Roster"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setCustomStyle()
        self.view.backgroundColor = UIColor.white
    }

    private func setupTableView() {
        self.tableView?.backgroundColor = UIColor.tableViewBackgroundColor
        self.view.backgroundColor = UIColor.tableViewBackgroundColor
        self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
    }

    private func viewModelSetUp() {
        viewModel = EmployeeViewModel()

        self.createSpinnerView()
        viewModel.employeeResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.removeSpinnerView()
                self?.employeeList = result
                self?.tableView?.reloadData()
                }, onError: { [weak self] error in
                    self?.removeSpinnerView()
                    DDLogError("onError: \(error)")
            }).disposed(by: disposeBag)

        viewModel
            .errorResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlertView(withTitle: error.localizedDescription, andMessage: (error as? EKEventError)?.recoverySuggestion)
            }).disposed(by: disposeBag)

        viewModel
            .openSettings
            .observeOn(MainScheduler.instance)
            .flatMap({ [weak self] result -> Observable<Int> in
                return self?.alertCalenderAccessNeeded(result.0, result.1) ?? Observable.empty()
            })
            .subscribe(onNext: { [weak self] index in
                index == 0 ? self?.openSettingsAppURL() : ()
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)

        viewModel
            .eventAddedToCalendar
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                let (title, message) = result
                self?.showAlertView(withTitle: title, andMessage: message)
            }).disposed(by: disposeBag)

        buttonRefresh.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.getRosterInfo()
            }).disposed(by: disposeBag)

        viewModel.getRosterInfoFromDB()
        viewModel.getRosterInfo()
    }

    private func openSettingsAppURL() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsAppURL)
    }

    private func alertCalenderAccessNeeded(_ title: String, _ message: String) -> Observable<Int> {
        return self.alert(title: title,
                          message: message,
            actions: [AlertAction(title: "Settings", type: 0, style: .default),
                      AlertAction(title: "Cancel", type: 1, style: .destructive)],
            viewController: self)
    }
}

// MARK: - TableViewDelegate Setup
extension EmployeeRosterVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let employeeSection = EmployeeSectionModel(rawValue: indexPath.section)
        switch employeeSection {
        case .header:
            return 200
        default:
            return 150
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.employeeList != nil ? 2 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let employeeSection = EmployeeSectionModel(rawValue: section)

        switch employeeSection {
        case .header:
            return self.employeeList != nil ? 1 : 0

        default:
            return self.employeeList?.roster?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeSection = EmployeeSectionModel(rawValue: indexPath.section)

        switch employeeSection {
        case .header:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as RosterTableViewCell
            cell.configure(self.employeeList?.scheduledToday)
            return cell

        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EmployeeDetailCell
            cell.configure(self.employeeList?.roster?[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DDLogInfo("tapped")
        guard let roster = self.employeeList?.roster else {
            return
        }
        let dataValue = roster[indexPath.row]
        viewModel.addEventToCalendar(withRosterModel: dataValue)
    }
}
