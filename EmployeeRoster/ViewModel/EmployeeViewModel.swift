//
//  EmployeeViewModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import CocoaLumberjack

class EmployeeViewModel: EmployeeViewModelProtocol {
    //input
    private let getEmployeeHandler: GetEmployeeInfoHandlerProtocol
    private let realmManager: RealmManagerDataSource

    //output
    var employeeResult: Observable<EmployeeModel>
    var errorResult: Observable<Error>

    private let employeeResultSubject = PublishSubject<EmployeeModel>()
    private let errorResultSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()

    init(withGetWeather getEmployeeHandler: GetEmployeeInfoHandlerProtocol = GetEmployeeInfoHandler(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager()) {
        self.getEmployeeHandler = getEmployeeHandler
        self.realmManager = realmManager

        self.employeeResult = employeeResultSubject.asObserver()
        self.errorResult = errorResultSubject.asObserver()
        self.reloadTask()
    }

    private func reloadTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(500), scheduler: scheduler)
            .subscribe { [weak self] _ in
                self?.getRosterInfo()
            }.disposed(by: disposeBag)
    }

    // Get employee roster from server
    func getRosterInfo() {
        self.getEmployeeHandler
            .request()
            .retry(3)
            .map { [weak self] result -> EmployeeModel in
                self?.employeeResultSubject.on(.next(result))
                return result
            }
            .flatMap { result -> Completable in
                return self.realmManager.saveEmployeeInfo(withInfo: result)
            }.subscribe(onNext: { _ in
                DDLogInfo("onNext")
            }, onError: { [weak self] error in
                DDLogError("onError: \(error)")
                self?.errorResultSubject.on(.next(error))

                }, onCompleted: {
                    DDLogInfo("onCompleted")

            }).disposed(by: disposeBag)
    }

    // Get employee roster from DB
    func getRosterInfoFromDB() {
        realmManager
            .fetchEmployeeInfo()
            .subscribe(onSuccess: { [weak self] result in
                self?.employeeResultSubject.on(.next(result))
                }, onError: { error in
                    print("fetch from DB error :", error)
            }).disposed(by: disposeBag)
    }

}
