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

final class EmployeeViewModel: EmployeeViewModelProtocol {
    //input
    private let getEmployeeHandler: GetEmployeeInfoHandlerProtocol
    private let realmManager: RealmManagerDataSource
    private let eventsCalendarManager: EventsCalendarManagerDataSource

    //output
    var employeeResult: Observable<EmployeeModel>
    var errorResult: Observable<Error>
    var openSettings: Observable<(String, String)>
    var eventAddedToCalendar: Observable<(String, String)>

    private let employeeResultSubject = PublishSubject<EmployeeModel>()
    private let errorResultSubject = PublishSubject<Error>()
    private let openSettingsSubject = PublishSubject<(String, String)>()
    private let eventAddedToCalendarSubject = PublishSubject<(String, String)>()

    private let disposeBag = DisposeBag()

    init(withGetWeather getEmployeeHandler: GetEmployeeInfoHandlerProtocol = GetEmployeeInfoHandler(),
         withRealmManager realmManager: RealmManagerDataSource = RealmManager(),
         withEventsCalendarManager eventsCalendarManager: EventsCalendarManagerDataSource = EventsCalendarManager()
    ) {
        self.getEmployeeHandler = getEmployeeHandler
        self.realmManager = realmManager
        self.eventsCalendarManager = eventsCalendarManager

        self.employeeResult = employeeResultSubject.asObserver()
        self.errorResult = errorResultSubject.asObserver()
        self.openSettings = openSettingsSubject.asObserver()
        self.eventAddedToCalendar = eventAddedToCalendarSubject.asObserver()
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
        .flatMap { [weak self] result -> Completable in
            return self?.realmManager.saveEmployeeInfo(withInfo: result) ?? Completable.empty()
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
                    DDLogError("fetch from DB error : \(error)")
            }).disposed(by: disposeBag)
    }

    // Check Calendar permissions auth status
    // Try to add an event to the calendar if authorized

    func addEventToCalendar(withRosterModel rosterModel: RosterModel) {

        guard let event = EventsModel(withRosterModel: rosterModel) else {
            return
        }

        self.eventsCalendarManager
            .addEventToCalendar(event: event)
//            .presentCalendarModalToAddEvent(event: event)
            .subscribe(onCompleted: { [weak self] in
                DDLogInfo("eventsCalendarManager onCompleted")
                let result = ("Event added to Calendar", "Event added to Calendar completed")
                self?.eventAddedToCalendarSubject.onNext(result)

            }, onError: { [weak self] error in
                DDLogError("eventsCalendarManager error : \(error)")

                if error as? EKEventError == .calendarAccessDeniedOrRestricted {
                    let appName = Bundle.main.displayName ?? "This app"
                    let result = ("This feature requires calender access", "In iPhone settings, tap \(appName) and turn on calender access")
                    self?.openSettingsSubject.onNext(result)
                } else {
                    self?.errorResultSubject.onNext(error)
                }
            })
            .disposed(by: disposeBag)
    }

}
