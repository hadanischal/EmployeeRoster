//
//  EmployeeRosterViewController.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 27/8/20.
//  Copyright © 2020 NischalHada. All rights reserved.
//

import CocoaLumberjack
import RxCocoa
import RxSwift
import UIKit

final class EmployeeRosterViewController: UIViewController, BaseViewProtocol {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonRefresh: UIBarButtonItem!
    private var viewModel: EmployeeListDataSource!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupViewModel()
    }

    private func setupUI() {
        navigationItem.title = "Roster"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setCustomStyle()
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.tableViewBackgroundColor
        view.backgroundColor = UIColor.tableViewBackgroundColor
        tableView.register(RosterTableViewCell.self)
        tableView.register(EmployeeDetailCell.self)
        tableView?.tableFooterView = UIView(frame: CGRect.zero)
    }

    private func setupViewModel() {
        viewModel = EmployeeListViewModel()

        viewModel.updateInfo
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel
            .errorResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.showAlertView(withTitle: error.localizedDescription, andMessage: error.localizedDescription)
            }).disposed(by: disposeBag)

        viewModel.isLoading.bind(to: isAnimating).disposed(by: disposeBag)

        viewModel.viewDidLoad()
    }

    @IBAction func actionRefresh(_ sender: UIBarButtonItem) {
        viewModel.viewDidLoad()
    }

    private func alertCalenderAccessNeeded(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { [weak self] (_: UIAlertAction) in
            self?.openSettingsAppURL()
        }

        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        self.present(alert, animated: true, completion: nil)
    }

    private func openSettingsAppURL() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(settingsAppURL)
    }
}

// MARK: - TableViewDelegate Setup

extension EmployeeRosterViewController: UITableViewDataSource, UITableViewDelegate {
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
        viewModel?.employeeList.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.employeeList[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeSection = EmployeeSectionModel(rawValue: indexPath.section)
        let data = viewModel.employeeList[indexPath.section][indexPath.row]

        switch employeeSection {
        case .header:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as RosterTableViewCell
            cell.configure(data)
            return cell

        default:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EmployeeDetailCell
            cell.configure(data)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
