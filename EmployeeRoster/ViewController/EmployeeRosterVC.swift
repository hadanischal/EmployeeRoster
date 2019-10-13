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

class EmployeeRosterVC: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    var activityIndicator: ActivityIndicator? = ActivityIndicator()

    @IBOutlet weak var buttonRefresh: UIBarButtonItem!
    private let disposeBag = DisposeBag()
    var viewModel: EmployeeViewModelProtocol!
    private var employeeList: EmployeeModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.viewModelSetUp()
    }

    func setupUI() {
        self.navigationItem.title = "Roster"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setCustomStyle()
        self.view.backgroundColor = UIColor.white
    }

    func setupTableView() {
        self.tableView?.backgroundColor = UIColor.tableViewBackgroundColor
        self.view.backgroundColor = UIColor.tableViewBackgroundColor
        self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
    }

    func viewModelSetUp() {
        viewModel = EmployeeViewModel()
        viewModel.employeeResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.employeeList = result
                self?.tableView?.reloadData()
            }, onError: { error in
                DDLogError("onError: \(error)")
            }).disposed(by: disposeBag)

        viewModel
            .errorResult
            .subscribe(onNext: { error in
                DDLogError("onError: \(error)")
            })
            .disposed(by: disposeBag)

        buttonRefresh.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.getRosterInfo()
            }).disposed(by: disposeBag)

        viewModel.getRosterInfoFromDB()
        viewModel.getRosterInfo()
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
            cell.dataValue = self.employeeList?.scheduledToday
            return cell

        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EmployeeDetailCell
            guard let roster = self.employeeList?.roster else {
                return cell
            }
            cell.dataValue = roster[indexPath.row]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DDLogInfo("tapped")
    }
}
