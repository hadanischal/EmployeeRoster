//
//  EmployeeListModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 28/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

protocol EmployeeListRepositoryHandling: AnyObject {
    func getRosterInfo() -> Observable<[[EmployeeListDTO]]>
}

final class EmployeeListRepository: EmployeeListRepositoryHandling {
    private let getEmployeeHandler: EmployeeNetworkHandling
    private let realmManager: RealmManagerDataSource
    private let disposeBag = DisposeBag()

    init(withGetWeather getEmployeeHandler: EmployeeNetworkHandling = EmployeeNetworkHandler(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager()) {
        self.getEmployeeHandler = getEmployeeHandler
        self.realmManager = realmManager
    }

    func getRosterInfo() -> Observable<[[EmployeeListDTO]]> {
        let result = Observable.concat(getEmployeeInfoFromLocalDb(), getEmployeeInfoFromServer())
        return result.map { self.employeeList($0) }
    }

    // Get employee roster from server
    func getEmployeeInfoFromServer() -> Observable<EmployeeModel> {
        self.getEmployeeHandler
            .request()
            .catchError { _ in Observable.empty() }
            .flatMap { [weak self] result -> Observable<EmployeeModel> in
                guard let self = self else { return Observable.empty() }
                return self.saveEmployeeInfo(withInfo: result)
                    .andThen(Observable.just(result))
        }
    }

    // Get employee roster from DB
    private func getEmployeeInfoFromLocalDb() -> Observable<EmployeeModel> {
        realmManager.fetchEmployeeInfo().asObservable()
            .catchError { _ in Observable.empty() }
    }

    // Save EmployeeInfo to DB
    private func saveEmployeeInfo(withInfo data: EmployeeModel) -> Completable {
        return self.realmManager.saveEmployeeInfo(withInfo: data)
            .catchError { _ in Completable.empty() }
    }

    func employeeList(_ data: EmployeeModel) -> [[EmployeeListDTO]] {
        guard let scheduledToday = data.scheduledToday,
            let roster = data.roster
            else { return [] }

        return [[EmployeeListDTO(scheduledToday)],
                roster.map { EmployeeListDTO($0) }]
    }
}
