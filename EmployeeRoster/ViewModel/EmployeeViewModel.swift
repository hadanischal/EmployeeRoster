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

enum AddEventRoute {
    case eventAdded(String, String)
    case openSettings(String, String)
    case errorResult(Error)
}

final class EmployeeViewModel: EmployeeViewModelProtocol {
    //input
    private let employeeListModel: EmployeeListModelDataSource
    private let eventsCalendarManager: EventsCalendarManagerDataSource

    //output
    var employeeResult: Observable<EmployeeModel>
    var errorResult: Observable<Error>

    private let employeeResultSubject = PublishSubject<EmployeeModel>()
    private let errorResultSubject = PublishSubject<Error>()

    private let disposeBag = DisposeBag()

    init(withEmployeeListModel employeeListModel: EmployeeListModelDataSource = EmployeeListModel(),
         withEventsCalendarManager eventsCalendarManager: EventsCalendarManagerDataSource = EventsCalendarManager()) {
        self.employeeListModel = employeeListModel
        self.eventsCalendarManager = eventsCalendarManager

        self.employeeResult = employeeResultSubject.asObserver()
        self.errorResult = errorResultSubject.asObserver()
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
    func addEventToCalendar(withRosterModel rosterModel: RosterModel) -> Observable<AddEventRoute> {

        guard let event = EventsModel(withRosterModel: rosterModel) else { return Observable.empty() }

        return self.eventsCalendarManager
            .addEventToCalendar(event: event)
            //            .presentCalendarModalToAddEvent(event: event)
            .asObservable()
            .catchError({ (error) -> Observable<EventsCalendarStatus> in
                return Observable.just(EventsCalendarStatus.error(error as? EKEventError ?? EKEventError.eventNotAddedToCalendar))
            })
            .flatMap({ calendarStatus -> Observable<AddEventRoute> in
                switch calendarStatus {
                case .added:
                    let result = ("Event added to Calendar", "Event added to Calendar completed")
                    return Observable.just(AddEventRoute.eventAdded(result.0, result.1))

                case .denied:
                    let appName = Bundle.main.displayName ?? "This app"
                    let result = ("This feature requires calender access", "In iPhone settings, tap \(appName) and turn on calender access")
                    return Observable.just(AddEventRoute.openSettings(result.0, result.1))

                case .error(let error):
                    return Observable.just(AddEventRoute.errorResult(error))
                }
            })
    }

}
