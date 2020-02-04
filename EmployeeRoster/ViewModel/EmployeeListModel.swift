//
//  EmployeeListModel.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 28/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

protocol EmployeeListModelDataSource {
    func getRosterInfo() -> Observable<EmployeeModel>
}

final class EmployeeListModel: EmployeeListModelDataSource {

    private let getEmployeeHandler: GetEmployeeInfoHandlerProtocol
    private let realmManager: RealmManagerDataSource
    private let disposeBag = DisposeBag()

    init(withGetWeather getEmployeeHandler: GetEmployeeInfoHandlerProtocol = GetEmployeeInfoHandler(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager()) {
        self.getEmployeeHandler = getEmployeeHandler
        self.realmManager = realmManager
    }

    func getRosterInfo() -> Observable<EmployeeModel> {
        let result = Observable.concat(getEmployeeInfoFromLocalDb(), getEmployeeInfoFromServer())
        return result
    }
    // Get employee roster from server
    func getEmployeeInfoFromServer() -> Observable<EmployeeModel> {
        self.getEmployeeHandler
            .request()
            .retry(3)
            .catchError { _ in Observable.empty()}
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

    //save EmployeeInfo to DB
    private func saveEmployeeInfo(withInfo data: EmployeeModel) -> Completable {
        return self.realmManager.saveEmployeeInfo(withInfo: data)
            .catchError { _ in Completable.empty()}
    }

}
