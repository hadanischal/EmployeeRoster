//
//  EventsCalendarManager.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 12/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import EventKitUI
import RxSwift
import EventStoreHelperRx

protocol EventsCalendarManagerDataSource {
    func addEventToCalendar(event: EventsModel) -> Completable
    func presentCalendarModalToAddEvent(event: EventsModel) -> Completable
}

class EventsCalendarManager: NSObject, EventsCalendarManagerDataSource {

    private var eventStore: EKEventStore!
    private var eventHelper: EKEventHelperDataSource!

    init(withEKEventHelper eventHelper: EKEventHelperDataSource = EKEventHelper(),
         withEventStore eventStore: EKEventStore = EKEventStore()) {
        self.eventHelper = eventHelper
        self.eventStore = eventStore
    }

    // Check Calendar permissions auth status
    // Try to add an event to the calendar if authorized

    func addEventToCalendar(event: EventsModel) -> Completable {
        return self.eventHelper
            .authorizationStatus
            .flatMapCompletable { authStatus -> Completable in
                switch authStatus {
                case .authorized:
                    return self.addEvent(event: event)
                case .notDetermined:
                    //Auth is not determined
                    //We should request access to the calendar
                    return self.eventHelper
                        .requestAccess
                        .flatMapCompletable { status -> Completable in
                            if status {
                                return self.addEvent(event: event)
                            }
                            return Completable.error(EKEventError.calendarAccessDeniedOrRestricted)
                    }
                case .denied, .restricted:
                    return Completable.error(EKEventError.calendarAccessDeniedOrRestricted)
                }
        }
    }

    // Try to save an event to the calendar
    private func addEvent(event: EventsModel) -> Completable {
        return Completable.create { completable in
            let eventToAdd = self.generateEvent(event: event)
            if !self.eventAlreadyExists(event: eventToAdd) {
                do {
                    try self.eventStore.save(eventToAdd, span: .thisEvent)
                } catch {
                    // Error while trying to create event in calendar
                    completable(.error(EKEventError.eventNotAddedToCalendar))
                }
                completable(.completed)
            } else {
                completable(.error(EKEventError.eventAlreadyExistsInCalendar))
            }
            return Disposables.create {}
        }
    }

    // Generate an event which will be then added to the calendar

    private func generateEvent(event: EventsModel) -> EKEvent {
        let newEvent = EKEvent(eventStore: eventStore)
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        newEvent.title = event.title
        newEvent.startDate = event.startDate
        newEvent.endDate = event.endDate
        newEvent.notes = event.notes
        // Set default alarm minutes before event
        let alarm = EKAlarm(relativeOffset: TimeInterval(event.alarmMinutesBefore*60))
        newEvent.addAlarm(alarm)
        return newEvent
    }

    // Check if the event was already added to the calendar

    private func eventAlreadyExists(event eventToAdd: EKEvent) -> Bool {
        let predicate = eventStore.predicateForEvents(withStart: eventToAdd.startDate, end: eventToAdd.endDate, calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)

        let eventAlreadyExists = existingEvents.contains { (event) -> Bool in
            return eventToAdd.title == event.title && event.startDate == eventToAdd.startDate && event.endDate == eventToAdd.endDate
        }
        return eventAlreadyExists
    }

    // Show event kit ui to add event to calendar

    func presentCalendarModalToAddEvent(event: EventsModel) -> Completable {
        return self.eventHelper
            .authorizationStatus
            .flatMapCompletable { authStatus -> Completable in
                switch authStatus {
                case .authorized:
                   return self.presentEventCalendarDetailModal(event: event)
                case .notDetermined:
                    //Auth is not determined
                    //We should request access to the calendar
                    return self.eventHelper
                        .requestAccess
                        .observeOn(MainScheduler.instance)
                        .flatMapCompletable { status -> Completable in
                            if status {
                               return self.presentEventCalendarDetailModal(event: event)
                            }
                            return Completable.error(EKEventError.calendarAccessDeniedOrRestricted)
                    }
                case .denied, .restricted:
                    return Completable.error(EKEventError.calendarAccessDeniedOrRestricted)
                }
        }
    }

    // Present edit event calendar modal
    private func presentEventCalendarDetailModal(event: EventsModel) -> Completable {
        return Completable.create { completable in
            let event = self.generateEvent(event: event)
            let eventModalVC = EKEventEditViewController()
            eventModalVC.event = event
            eventModalVC.eventStore = self.eventStore
            eventModalVC.editViewDelegate = self
            guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
                completable(.error(EKEventError.eventNotAddedToCalendar))
                return Disposables.create {}
            }
            rootVC.present(eventModalVC, animated: true, completion: nil)
            completable(.completed)
            return Disposables.create {}
        }
    }

}

// EKEventEditViewDelegate
extension EventsCalendarManager: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
