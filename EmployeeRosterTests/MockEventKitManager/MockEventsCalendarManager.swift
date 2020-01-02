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

public class MockEventsCalendarManagerDataSource: EventsCalendarManagerDataSource, Cuckoo.ProtocolMock {

    public typealias MocksType = EventsCalendarManagerDataSource

    public typealias Stubbing = __StubbingProxy_EventsCalendarManagerDataSource
    public typealias Verification = __VerificationProxy_EventsCalendarManagerDataSource

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: EventsCalendarManagerDataSource?

    public func enableDefaultImplementation(_ stub: EventsCalendarManagerDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    public func addEventToCalendar(event: EventsModel) -> Single<EventsCalendarStatus> {

    return cuckoo_manager.call("addEventToCalendar(event: EventsModel) -> Single<EventsCalendarStatus>",
            parameters: (event),
            escapingParameters: (event),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub!.addEventToCalendar(event: event))
    }

    public func presentCalendarModalToAddEvent(event: EventsModel) -> Single<EventsCalendarStatus> {

    return cuckoo_manager.call("presentCalendarModalToAddEvent(event: EventsModel) -> Single<EventsCalendarStatus>",
            parameters: (event),
            escapingParameters: (event),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(), defaultCall: __defaultImplStub!.presentCalendarModalToAddEvent(event: event))
    }

    public struct __StubbingProxy_EventsCalendarManagerDataSource: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager

        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }

        func addEventToCalendar<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubFunction<(EventsModel), Single<EventsCalendarStatus>> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEventsCalendarManagerDataSource.self, method: "addEventToCalendar(event: EventsModel) -> Single<EventsCalendarStatus>", parameterMatchers: matchers))
        }

        func presentCalendarModalToAddEvent<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubFunction<(EventsModel), Single<EventsCalendarStatus>> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEventsCalendarManagerDataSource.self, method: "presentCalendarModalToAddEvent(event: EventsModel) -> Single<EventsCalendarStatus>", parameterMatchers: matchers))
        }
    }

    public struct __VerificationProxy_EventsCalendarManagerDataSource: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation

        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }

        @discardableResult
        func addEventToCalendar<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(EventsModel), Single<EventsCalendarStatus>> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return cuckoo_manager.verify("addEventToCalendar(event: EventsModel) -> Single<EventsCalendarStatus>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }

        @discardableResult
        func presentCalendarModalToAddEvent<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(EventsModel), Single<EventsCalendarStatus>> where M1.MatchedType == EventsModel {
            let matchers: [Cuckoo.ParameterMatcher<(EventsModel)>] = [wrap(matchable: event) { $0 }]
            return cuckoo_manager.verify("presentCalendarModalToAddEvent(event: EventsModel) -> Single<EventsCalendarStatus>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
    }
}

public class EventsCalendarManagerDataSourceStub: EventsCalendarManagerDataSource {

    public func addEventToCalendar(event: EventsModel) -> Single<EventsCalendarStatus> {
        return DefaultValueRegistry.defaultValue(for: (Single<EventsCalendarStatus>).self)
    }

    public func presentCalendarModalToAddEvent(event: EventsModel) -> Single<EventsCalendarStatus> {
        return DefaultValueRegistry.defaultValue(for: (Single<EventsCalendarStatus>).self)
    }
}
