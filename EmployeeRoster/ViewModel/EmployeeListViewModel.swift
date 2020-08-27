//
//  EmployeeViewModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 7/3/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import CocoaLumberjack
import Foundation
import RxSwift

protocol EmployeeListDataSource {
    var updateInfo: Observable<Bool> { get }
    var errorResult: Observable<Error> { get }
    var isLoading: Observable<Bool> { get }
    var employeeList: [[EmployeeListDTO]] { get }
    func viewDidLoad()
}

final class EmployeeListViewModel: EmployeeListDataSource {
    // input
    private let repository: EmployeeListRepositoryHandling

    // output
    let updateInfo: Observable<Bool>
    var errorResult: Observable<Error>
    let isLoading: Observable<Bool>
    var employeeList: [[EmployeeListDTO]] = []

    private let updateInfoSubject = PublishSubject<Bool>()
    private let errorResultSubject = PublishSubject<Error>()
    private let loadingSubject = BehaviorSubject<Bool>(value: true)
    private let disposeBag = DisposeBag()

    init(withRepositoryHandling repository: EmployeeListRepositoryHandling = EmployeeListRepository()
    ) {
        self.repository = repository

        self.updateInfo = updateInfoSubject.asObservable()
        self.errorResult = errorResultSubject.asObserver()
        self.isLoading = loadingSubject.asObservable()

        self.reloadTask()
    }

    private func reloadTask() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        Observable<Int>.interval(.seconds(500), scheduler: scheduler)
            .flatMap { [weak self] _ -> Observable<[[EmployeeListDTO]]> in
                self?.getRosterInfo() ?? Observable.empty()
        }
        .subscribe(onNext: { [weak self] result in
            self?.employeeList = result
            self?.updateInfoSubject.onNext(true)
            self?.loadingSubject.onNext(false)

            }, onError: { [errorResultSubject] error in
                errorResultSubject.on(.next(error))
                self.loadingSubject.onNext(false)

        }).disposed(by: disposeBag)
    }

    func viewDidLoad() {
        self.updateRosterInfo()
    }

    // Get employee roster from server
    func updateRosterInfo() {
        self.getRosterInfo()
            .subscribe(onNext: { [weak self] result in
                self?.employeeList = result
                self?.updateInfoSubject.onNext(true)
                self?.loadingSubject.onNext(false)

                }, onError: { [errorResultSubject] error in
                    errorResultSubject.on(.next(error))
                    self.loadingSubject.onNext(false)

            }).disposed(by: disposeBag)
    }

    // Get employee roster Info From model
    private func getRosterInfo() -> Observable<[[EmployeeListDTO]]> {
        return self.repository.getRosterInfo()
    }
}
