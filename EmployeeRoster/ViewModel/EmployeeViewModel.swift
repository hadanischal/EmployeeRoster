//
//  EmployeeViewModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EmployeeViewModel: EmployeeViewModelProtocol {
    private let getEmployeeHandler: GetEmployeeInfoHandlerProtocol
    private let disposeBag = DisposeBag()
    var employeeResult: Observable<EmployeeModel>
    var errorResult: Observable<Error>

    private let employeeResultSubject = PublishSubject<EmployeeModel>()
    private let errorResultSubject = PublishSubject<Error>()

    init(withGetWeather getEmployeeHandler: GetEmployeeInfoHandlerProtocol = GetEmployeeInfoHandler()) {
        self.getEmployeeHandler = getEmployeeHandler
        self.employeeResult = employeeResultSubject.asObserver()
        self.errorResult = errorResultSubject.asObserver()
        self.reloadTask()
    }

    private func reloadTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(200), scheduler: scheduler)
            .subscribe { [weak self] _ in
                self?.getRosterInfo()
            }.disposed(by: disposeBag)
    }

    func getRosterInfo() {
        self.getEmployeeHandler.request()
            .retry(3)
            .catchError({ error -> Single<EmployeeModel> in
                print(error.localizedDescription)
                return Single.just(EmployeeModel.empty)
            })
            .catchErrorJustReturn(EmployeeModel.empty)
            .subscribe(onSuccess: { [weak self] result in
                self?.employeeResultSubject.on(.next(result))
                }, onError: { [weak self] error in
                    print("VM error :", error)
                    self?.errorResultSubject.on(.next(error))
            })
            .disposed(by: disposeBag)
    }
}
