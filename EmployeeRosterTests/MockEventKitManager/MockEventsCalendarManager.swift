//
//  MockEventsCalendarManager.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 13/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
//swiftlint:disable all

import Cuckoo
import EventKitUI
import EventStoreHelperRx
import RxSwift
import UIKit
@testable import EmployeeRoster

class MockEventsCalendarManagerDataSource: EventsCalendarManagerDataSource, Cuckoo.ProtocolMock {

    typealias MocksType = EventsCalendarManagerDataSource

    typealias Stubbing = __StubbingProxy_EventsCalendarManagerDataSource
    typealias Verification = __VerificationProxy_EventsCalendarManagerDataSource

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: EventsCalendarManagerDataSource?

    func enableDefaultImplementation(_ stub: EventsCalendarManagerDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    func addEventToCalendar(event: EventsModel) -> Completable {

        return cuckoo_manager.call("addEventToCalendar(event: EventsModel) -> Completable",
                                   parameters: (event),
                                   escapingParameters: (event),
                                   superclassCall:

            Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub!.addEventToCalendar(event: event))
    }

    func presentCalendarModalToAddEvent(event: EventsModel) -> Completable {

        return cuckoo_manager.call("presentCalendarModalToAddEvent(event: EventsModel) -> Completable",
                                   parameters: (event),
                                   escapingParameters: (event),
                                   superclassCall:

            Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub!.presentCalendarModalToAddEvent(event: event))
    }

    struct __StubbingProxy_EventsCalendarManagerDataSource: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }

        func addEventToCalendar<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubFunction<(EventsModel), Completable> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEventsCalendarManagerDataSource.self, method: "addEventToCalendar(event: EventsModel) -> Completable", parameterMatchers: matchers))
        }

        func presentCalendarModalToAddEvent<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubFunction<(EventsModel), Completable> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEventsCalendarManagerDataSource.self, method: "presentCalendarModalToAddEvent(event: EventsModel) -> Completable", parameterMatchers: matchers))
        }

    }

    struct __VerificationProxy_EventsCalendarManagerDataSource: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        @discardableResult
        func addEventToCalendar<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(EventsModel), Completable> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return cuckoo_manager.verify("addEventToCalendar(event: EventsModel) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }

        @discardableResult
        func presentCalendarModalToAddEvent<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(EventsModel), Completable> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return cuckoo_manager.verify("presentCalendarModalToAddEvent(event: EventsModel) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }

    }
}

class EventsCalendarManagerDataSourceStub: EventsCalendarManagerDataSource {

    func addEventToCalendar(event: EventsModel) -> Completable {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }

    func presentCalendarModalToAddEvent(event: EventsModel) -> Completable {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
}
