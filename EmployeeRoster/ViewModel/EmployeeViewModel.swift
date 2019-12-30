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
import EventStoreHelperRx

final class EmployeeViewModel: EmployeeViewModelProtocol {
    //input
    private let employeeListModel: EmployeeListModelDataSource
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

    init(withEmployeeListModel employeeListModel: EmployeeListModelDataSource = EmployeeListModel(),
         withEventsCalendarManager eventsCalendarManager: EventsCalendarManagerDataSource = EventsCalendarManager()) {
        self.employeeListModel = employeeListModel
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
            .flatMap { [weak self] _ -> Observable<EmployeeModel> in
                return self?.getRosterInfo() ?? Observable.empty()
        }
        .subscribe(onNext: { [employeeResultSubject] result in
            employeeResultSubject.onNext(result)
            }, onError: { [errorResultSubject] (error) in
                errorResultSubject.on(.next(error))
        }).disposed(by: disposeBag)
    }

    func viewDidLoad() {
        self.updateRosterInfo()
    }

    // Get employee roster from server
    func updateRosterInfo() {
        self.getRosterInfo()
            .subscribe(onNext: { [employeeResultSubject] result in
                employeeResultSubject.onNext(result)
                }, onError: { [errorResultSubject] (error) in
                    errorResultSubject.on(.next(error))
            }).disposed(by: disposeBag)
    }

    // Get employee roster Info From model
    private func getRosterInfo() -> Observable<EmployeeModel> {
        return self.employeeListModel.getRosterInfo()
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
