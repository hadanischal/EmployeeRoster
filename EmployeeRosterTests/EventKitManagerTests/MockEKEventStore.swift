//
//  MockEKEventStore.swift
//  EmployeeRosterTests
//
//  Created by Nischal Hada on 18/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//
//swiftlint:disable all
import Foundation
import Cuckoo
import EventKit

@testable import EmployeeRoster

public class MockEKEventStore: EKEventStore, Cuckoo.ClassMock {
    
    public typealias MocksType = EKEventStore
    
    public typealias Stubbing = __StubbingProxy_EKEventStore
    public typealias Verification = __VerificationProxy_EKEventStore
    
    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)
    
    
    private var __defaultImplStub: EKEventStore?
    
    public  func enableDefaultImplementation(_ stub: EKEventStore) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public override var eventStoreIdentifier: String {
        get {
            return cuckoo_manager.getter("eventStoreIdentifier",
                                         superclassCall:
                super.eventStoreIdentifier, defaultCall: __defaultImplStub!.eventStoreIdentifier)
        }
    }
    
    public override var delegateSources: [EKSource] {
        get {
            return cuckoo_manager.getter("delegateSources",
                                         superclassCall:
                super.delegateSources, defaultCall: __defaultImplStub!.delegateSources)
        }
    }
    
    public override var sources: [EKSource] {
        get {
            return cuckoo_manager.getter("sources",
                                         superclassCall:
                
                super.sources, defaultCall: __defaultImplStub!.sources)
        }
    }
    
    public override var defaultCalendarForNewEvents: EKCalendar? {
        get {
            return cuckoo_manager.getter("defaultCalendarForNewEvents",
                                         superclassCall:
                
                super.defaultCalendarForNewEvents, defaultCall: __defaultImplStub!.defaultCalendarForNewEvents)
        }
    }
    
    public override  func requestAccess(to entityType: EKEntityType, completion: @escaping EKEventStoreRequestAccessCompletionHandler)  {
        
        return cuckoo_manager.call("requestAccess(to: EKEntityType, completion: @escaping EKEventStoreRequestAccessCompletionHandler)",
                                   parameters: (entityType, completion),
                                   escapingParameters: (entityType, completion),
                                   superclassCall:
            
            super.requestAccess(to: entityType, completion: completion), defaultCall: __defaultImplStub!.requestAccess(to: entityType, completion: completion))
    }
    
    public override  func source(withIdentifier identifier: String) -> EKSource? {
        
        return cuckoo_manager.call("source(withIdentifier: String) -> EKSource?",
                                   parameters: (identifier),
                                   escapingParameters: (identifier),
                                   superclassCall:
            
            super.source(withIdentifier: identifier), defaultCall: __defaultImplStub!.source(withIdentifier: identifier))
    }
        
    public override  func calendars(for entityType: EKEntityType) -> [EKCalendar] {
        
        return cuckoo_manager.call("calendars(for: EKEntityType) -> [EKCalendar]",
                                   parameters: (entityType),
                                   escapingParameters: (entityType),
                                   superclassCall:
            
            super.calendars(for: entityType), defaultCall: __defaultImplStub!.calendars(for: entityType))
    }
    
    public override  func defaultCalendarForNewReminders() -> EKCalendar? {
        
        return cuckoo_manager.call("defaultCalendarForNewReminders() -> EKCalendar?",
                                   parameters: (),
                                   escapingParameters: (),
                                   superclassCall:
            
            super.defaultCalendarForNewReminders(), defaultCall: __defaultImplStub!.defaultCalendarForNewReminders())
    }
    
    public override  func calendar(withIdentifier identifier: String) -> EKCalendar? {
        
        return cuckoo_manager.call("calendar(withIdentifier: String) -> EKCalendar?",
                                   parameters: (identifier),
                                   escapingParameters: (identifier),
                                   superclassCall:
            
            super.calendar(withIdentifier: identifier), defaultCall: __defaultImplStub!.calendar(withIdentifier: identifier))
    }
    
    public override  func saveCalendar(_ calendar: EKCalendar, commit: Bool) throws {
        
        return try cuckoo_manager.callThrows("saveCalendar(_: EKCalendar, commit: Bool) throws",
                                             parameters: (calendar, commit),
                                             escapingParameters: (calendar, commit),
                                             superclassCall:
            
            super.saveCalendar(calendar, commit: commit), defaultCall: __defaultImplStub!.saveCalendar(calendar, commit: commit))
    }
    
    public override  func removeCalendar(_ calendar: EKCalendar, commit: Bool) throws {
        
        return try cuckoo_manager.callThrows("removeCalendar(_: EKCalendar, commit: Bool) throws",
                                             parameters: (calendar, commit),
                                             escapingParameters: (calendar, commit),
                                             superclassCall:
            
            super.removeCalendar(calendar, commit: commit), defaultCall: __defaultImplStub!.removeCalendar(calendar, commit: commit))
    }
    
    public override  func calendarItem(withIdentifier identifier: String) -> EKCalendarItem? {
        
        return cuckoo_manager.call("calendarItem(withIdentifier: String) -> EKCalendarItem?",
                                   parameters: (identifier),
                                   escapingParameters: (identifier),
                                   superclassCall:
            
            super.calendarItem(withIdentifier: identifier), defaultCall: __defaultImplStub!.calendarItem(withIdentifier: identifier))
    }
        
    public override  func calendarItems(withExternalIdentifier externalIdentifier: String) -> [EKCalendarItem] {
        
        return cuckoo_manager.call("calendarItems(withExternalIdentifier: String) -> [EKCalendarItem]",
                                   parameters: (externalIdentifier),
                                   escapingParameters: (externalIdentifier),
                                   superclassCall:
            
            super.calendarItems(withExternalIdentifier: externalIdentifier), defaultCall: __defaultImplStub!.calendarItems(withExternalIdentifier: externalIdentifier))
    }
    
    public override  func save(_ event: EKEvent, span: EKSpan) throws {
        
        return try cuckoo_manager.callThrows("save(_: EKEvent, span: EKSpan) throws",
                                             parameters: (event, span),
                                             escapingParameters: (event, span),
                                             superclassCall:
            
            super.save(event, span: span), defaultCall: __defaultImplStub!.save(event, span: span))
    }
    
    public override  func remove(_ event: EKEvent, span: EKSpan) throws {
        
        return try cuckoo_manager.callThrows("remove(_: EKEvent, span: EKSpan) throws",
                                             parameters: (event, span),
                                             escapingParameters: (event, span),
                                             superclassCall:
            
            super.remove(event, span: span), defaultCall: __defaultImplStub!.remove(event, span: span))
    }
    
    public override  func save(_ event: EKEvent, span: EKSpan, commit: Bool) throws {
        
        return try cuckoo_manager.callThrows("save(_: EKEvent, span: EKSpan, commit: Bool) throws",
                                             parameters: (event, span, commit),
                                             escapingParameters: (event, span, commit),
                                             superclassCall:
            
            super.save(event, span: span, commit: commit), defaultCall: __defaultImplStub!.save(event, span: span, commit: commit))
    }
    
    public override  func remove(_ event: EKEvent, span: EKSpan, commit: Bool) throws {
        
        return try cuckoo_manager.callThrows("remove(_: EKEvent, span: EKSpan, commit: Bool) throws",
                                             parameters: (event, span, commit),
                                             escapingParameters: (event, span, commit),
                                             superclassCall:
            super.remove(event, span: span, commit: commit), defaultCall: __defaultImplStub!.remove(event, span: span, commit: commit))
    }
    
    public override  func event(withIdentifier identifier: String) -> EKEvent? {
        
        return cuckoo_manager.call("event(withIdentifier: String) -> EKEvent?",
                                   parameters: (identifier),
                                   escapingParameters: (identifier),
                                   superclassCall:
            
            super.event(withIdentifier: identifier), defaultCall: __defaultImplStub!.event(withIdentifier: identifier))
    }
    
    public override  func events(matching predicate: NSPredicate) -> [EKEvent] {
        
        return cuckoo_manager.call("events(matching: NSPredicate) -> [EKEvent]",
                                   parameters: (predicate),
                                   escapingParameters: (predicate),
                                   superclassCall:
            super.events(matching: predicate), defaultCall: __defaultImplStub!.events(matching: predicate))
    }
    
    public override  func enumerateEvents(matching predicate: NSPredicate, using block: @escaping EKEventSearchCallback)  {
        
        return cuckoo_manager.call("enumerateEvents(matching: NSPredicate, using: @escaping EKEventSearchCallback)",
                                   parameters: (predicate, block),
                                   escapingParameters: (predicate, block),
                                   superclassCall:
            
            super.enumerateEvents(matching: predicate, using: block), defaultCall: __defaultImplStub!.enumerateEvents(matching: predicate, using: block))
    }
    
    public override  func predicateForEvents(withStart startDate: Date, end endDate: Date, calendars: [EKCalendar]?) -> NSPredicate {
        
        return cuckoo_manager.call("predicateForEvents(withStart: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate",
                                   parameters: (startDate, endDate, calendars),
                                   escapingParameters: (startDate, endDate, calendars),
                                   superclassCall:
            
            super.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars), defaultCall: __defaultImplStub!.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars))
    }
    
    public override  func save(_ reminder: EKReminder, commit: Bool) throws {
        
        return try cuckoo_manager.callThrows("save(_: EKReminder, commit: Bool) throws",
                                             parameters: (reminder, commit),
                                             escapingParameters: (reminder, commit),
                                             superclassCall:
            
            super.save(reminder, commit: commit), defaultCall: __defaultImplStub!.save(reminder, commit: commit))
    }
    
    public override  func remove(_ reminder: EKReminder, commit: Bool) throws {
        
        return try cuckoo_manager.callThrows("remove(_: EKReminder, commit: Bool) throws",
                                             parameters: (reminder, commit),
                                             escapingParameters: (reminder, commit),
                                             superclassCall:
            
            super.remove(reminder, commit: commit), defaultCall: __defaultImplStub!.remove(reminder, commit: commit))
    }
    
    public override  func fetchReminders(matching predicate: NSPredicate, completion: @escaping ([EKReminder]?) -> Void) -> Any {
        
        return cuckoo_manager.call("fetchReminders(matching: NSPredicate, completion: @escaping ([EKReminder]?) -> Void) -> Any",
                                   parameters: (predicate, completion),
                                   escapingParameters: (predicate, completion),
                                   superclassCall:
            
            super.fetchReminders(matching: predicate, completion: completion), defaultCall: __defaultImplStub!.fetchReminders(matching: predicate, completion: completion))
    }
    
    public override  func cancelFetchRequest(_ fetchIdentifier: Any)  {
        
        return cuckoo_manager.call("cancelFetchRequest(_: Any)",
                                   parameters: (fetchIdentifier),
                                   escapingParameters: (fetchIdentifier),
                                   superclassCall:
            
            super.cancelFetchRequest(fetchIdentifier), defaultCall: __defaultImplStub!.cancelFetchRequest(fetchIdentifier))
    }
    
    public override  func predicateForReminders(in calendars: [EKCalendar]?) -> NSPredicate {
        
        return cuckoo_manager.call("predicateForReminders(in: [EKCalendar]?) -> NSPredicate",
                                   parameters: (calendars),
                                   escapingParameters: (calendars),
                                   superclassCall:
            
            super.predicateForReminders(in: calendars), defaultCall: __defaultImplStub!.predicateForReminders(in: calendars))
    }
    
    public override  func predicateForIncompleteReminders(withDueDateStarting startDate: Date?, ending endDate: Date?, calendars: [EKCalendar]?) -> NSPredicate {
        
        return cuckoo_manager.call("predicateForIncompleteReminders(withDueDateStarting: Date?, ending: Date?, calendars: [EKCalendar]?) -> NSPredicate",
                                   parameters: (startDate, endDate, calendars),
                                   escapingParameters: (startDate, endDate, calendars),
                                   superclassCall:
            
            super.predicateForIncompleteReminders(withDueDateStarting: startDate, ending: endDate, calendars: calendars),
                                   defaultCall: __defaultImplStub!.predicateForIncompleteReminders(withDueDateStarting: startDate, ending: endDate, calendars: calendars))
    }
    
    public override  func predicateForCompletedReminders(withCompletionDateStarting startDate: Date?, ending endDate: Date?, calendars: [EKCalendar]?) -> NSPredicate {
        
        return cuckoo_manager.call("predicateForCompletedReminders(withCompletionDateStarting: Date?, ending: Date?, calendars: [EKCalendar]?) -> NSPredicate",
                                   parameters: (startDate, endDate, calendars),
                                   escapingParameters: (startDate, endDate, calendars),
                                   superclassCall:
            
            super.predicateForCompletedReminders(withCompletionDateStarting: startDate, ending: endDate, calendars: calendars),
                                   defaultCall: __defaultImplStub!.predicateForCompletedReminders(withCompletionDateStarting: startDate, ending: endDate, calendars: calendars))
    }
    
    public override  func commit() throws {
        
        return try cuckoo_manager.callThrows("commit() throws",
                                             parameters: (),
                                             escapingParameters: (),
                                             superclassCall:
            
            super.commit(), defaultCall: __defaultImplStub!.commit())
    }
    
    public override  func reset()  {
        
        return cuckoo_manager.call("reset()",
                                   parameters: (),
                                   escapingParameters: (),
                                   superclassCall:
            
            super.reset(), defaultCall: __defaultImplStub!.reset())
    }
    
    public override  func refreshSourcesIfNecessary()  {
        
        return cuckoo_manager.call("refreshSourcesIfNecessary()",
                                   parameters: (),
                                   escapingParameters: (),
                                   superclassCall:
            
            super.refreshSourcesIfNecessary(), defaultCall: __defaultImplStub!.refreshSourcesIfNecessary())
    }
    
    public struct __StubbingProxy_EKEventStore: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var eventStoreIdentifier: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEKEventStore, String> {
            return .init(manager: cuckoo_manager, name: "eventStoreIdentifier")
        }
        
        var delegateSources: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEKEventStore, [EKSource]> {
            return .init(manager: cuckoo_manager, name: "delegateSources")
        }
        
        var sources: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEKEventStore, [EKSource]> {
            return .init(manager: cuckoo_manager, name: "sources")
        }
        
        var defaultCalendarForNewEvents: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockEKEventStore, EKCalendar?> {
            return .init(manager: cuckoo_manager, name: "defaultCalendarForNewEvents")
        }
        
        func requestAccess<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(to entityType: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(EKEntityType, EKEventStoreRequestAccessCompletionHandler)> where M1.MatchedType == EKEntityType, M2.MatchedType == EKEventStoreRequestAccessCompletionHandler {
            let matchers: [Cuckoo.ParameterMatcher<(EKEntityType, EKEventStoreRequestAccessCompletionHandler)>] = [wrap(matchable: entityType) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "requestAccess(to: EKEntityType, completion: @escaping EKEventStoreRequestAccessCompletionHandler)", parameterMatchers: matchers))
        }
        
        func source<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.ProtocolStubFunction<(String), EKSource?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "source(withIdentifier: String) -> EKSource?", parameterMatchers: matchers))
        }
        
        func calendars<M1: Cuckoo.Matchable>(for entityType: M1) -> Cuckoo.ProtocolStubFunction<(EKEntityType), [EKCalendar]> where M1.MatchedType == EKEntityType {
            let matchers: [Cuckoo.ParameterMatcher<(EKEntityType)>] = [wrap(matchable: entityType) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "calendars(for: EKEntityType) -> [EKCalendar]", parameterMatchers: matchers))
        }
        
        func defaultCalendarForNewReminders() -> Cuckoo.ProtocolStubFunction<(), EKCalendar?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "defaultCalendarForNewReminders() -> EKCalendar?", parameterMatchers: matchers))
        }
        
        func calendar<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.ProtocolStubFunction<(String), EKCalendar?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "calendar(withIdentifier: String) -> EKCalendar?", parameterMatchers: matchers))
        }
        
        func saveCalendar<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ calendar: M1, commit: M2) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKCalendar, Bool)> where M1.MatchedType == EKCalendar, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKCalendar, Bool)>] = [wrap(matchable: calendar) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "saveCalendar(_: EKCalendar, commit: Bool) throws", parameterMatchers: matchers))
        }
        
        func removeCalendar<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ calendar: M1, commit: M2) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKCalendar, Bool)> where M1.MatchedType == EKCalendar, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKCalendar, Bool)>] = [wrap(matchable: calendar) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "removeCalendar(_: EKCalendar, commit: Bool) throws", parameterMatchers: matchers))
        }
        
        func calendarItem<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.ProtocolStubFunction<(String), EKCalendarItem?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "calendarItem(withIdentifier: String) -> EKCalendarItem?", parameterMatchers: matchers))
        }
        
        func calendarItems<M1: Cuckoo.Matchable>(withExternalIdentifier externalIdentifier: M1) -> Cuckoo.ProtocolStubFunction<(String), [EKCalendarItem]> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: externalIdentifier) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "calendarItems(withExternalIdentifier: String) -> [EKCalendarItem]", parameterMatchers: matchers))
        }
        
        func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, span: M2) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKEvent, EKSpan)> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "save(_: EKEvent, span: EKSpan) throws", parameterMatchers: matchers))
        }
        
        func remove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, span: M2) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKEvent, EKSpan)> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "remove(_: EKEvent, span: EKSpan) throws", parameterMatchers: matchers))
        }
        
        func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ event: M1, span: M2, commit: M3) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKEvent, EKSpan, Bool)> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan, M3.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan, Bool)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }, wrap(matchable: commit) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "save(_: EKEvent, span: EKSpan, commit: Bool) throws", parameterMatchers: matchers))
        }
        
        func remove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ event: M1, span: M2, commit: M3) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKEvent, EKSpan, Bool)> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan, M3.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan, Bool)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }, wrap(matchable: commit) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "remove(_: EKEvent, span: EKSpan, commit: Bool) throws", parameterMatchers: matchers))
        }
        
        func event<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.ProtocolStubFunction<(String), EKEvent?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "event(withIdentifier: String) -> EKEvent?", parameterMatchers: matchers))
        }
        
        func events<M1: Cuckoo.Matchable>(matching predicate: M1) -> Cuckoo.ProtocolStubFunction<(NSPredicate), [EKEvent]> where M1.MatchedType == NSPredicate {
            let matchers: [Cuckoo.ParameterMatcher<(NSPredicate)>] = [wrap(matchable: predicate) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "events(matching: NSPredicate) -> [EKEvent]", parameterMatchers: matchers))
        }
        
        func enumerateEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(matching predicate: M1, using block: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(NSPredicate, EKEventSearchCallback)> where M1.MatchedType == NSPredicate, M2.MatchedType == EKEventSearchCallback {
            let matchers: [Cuckoo.ParameterMatcher<(NSPredicate, EKEventSearchCallback)>] = [wrap(matchable: predicate) { $0.0 }, wrap(matchable: block) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "enumerateEvents(matching: NSPredicate, using: @escaping EKEventSearchCallback)", parameterMatchers: matchers))
        }
        
        func predicateForEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(withStart startDate: M1, end endDate: M2, calendars: M3) -> Cuckoo.ProtocolStubFunction<(Date, Date, [EKCalendar]?), NSPredicate> where M1.MatchedType == Date, M2.MatchedType == Date, M3.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<(Date, Date, [EKCalendar]?)>] = [wrap(matchable: startDate) { $0.0 }, wrap(matchable: endDate) { $0.1 }, wrap(matchable: calendars) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "predicateForEvents(withStart: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate", parameterMatchers: matchers))
        }
        
        func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ reminder: M1, commit: M2) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKReminder, Bool)> where M1.MatchedType == EKReminder, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKReminder, Bool)>] = [wrap(matchable: reminder) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "save(_: EKReminder, commit: Bool) throws", parameterMatchers: matchers))
        }
        
        func remove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ reminder: M1, commit: M2) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(EKReminder, Bool)> where M1.MatchedType == EKReminder, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKReminder, Bool)>] = [wrap(matchable: reminder) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "remove(_: EKReminder, commit: Bool) throws", parameterMatchers: matchers))
        }
        
        func fetchReminders<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(matching predicate: M1, completion: M2) -> Cuckoo.ProtocolStubFunction<(NSPredicate, ([EKReminder]?) -> Void), Any> where M1.MatchedType == NSPredicate, M2.MatchedType == ([EKReminder]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(NSPredicate, ([EKReminder]?) -> Void)>] = [wrap(matchable: predicate) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "fetchReminders(matching: NSPredicate, completion: @escaping ([EKReminder]?) -> Void) -> Any", parameterMatchers: matchers))
        }
        
        func cancelFetchRequest<M1: Cuckoo.Matchable>(_ fetchIdentifier: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Any)> where M1.MatchedType == Any {
            let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: fetchIdentifier) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "cancelFetchRequest(_: Any)", parameterMatchers: matchers))
        }
        
        func predicateForReminders<M1: Cuckoo.OptionalMatchable>(in calendars: M1) -> Cuckoo.ProtocolStubFunction<([EKCalendar]?), NSPredicate> where M1.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<([EKCalendar]?)>] = [wrap(matchable: calendars) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "predicateForReminders(in: [EKCalendar]?) -> NSPredicate", parameterMatchers: matchers))
        }
        
        func predicateForIncompleteReminders<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(withDueDateStarting startDate: M1, ending endDate: M2, calendars: M3) -> Cuckoo.ProtocolStubFunction<(Date?, Date?, [EKCalendar]?), NSPredicate> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, [EKCalendar]?)>] = [wrap(matchable: startDate) { $0.0 }, wrap(matchable: endDate) { $0.1 }, wrap(matchable: calendars) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "predicateForIncompleteReminders(withDueDateStarting: Date?, ending: Date?, calendars: [EKCalendar]?) -> NSPredicate", parameterMatchers: matchers))
        }
        
        func predicateForCompletedReminders<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(withCompletionDateStarting startDate: M1, ending endDate: M2, calendars: M3) -> Cuckoo.ProtocolStubFunction<(Date?, Date?, [EKCalendar]?), NSPredicate> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, [EKCalendar]?)>] = [wrap(matchable: startDate) { $0.0 }, wrap(matchable: endDate) { $0.1 }, wrap(matchable: calendars) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "predicateForCompletedReminders(withCompletionDateStarting: Date?, ending: Date?, calendars: [EKCalendar]?) -> NSPredicate", parameterMatchers: matchers))
        }
        
        func commit() -> Cuckoo.ProtocolStubNoReturnThrowingFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "commit() throws", parameterMatchers: matchers))
        }
        
        func reset() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "reset()", parameterMatchers: matchers))
        }
        
        func refreshSourcesIfNecessary() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockEKEventStore.self, method: "refreshSourcesIfNecessary()", parameterMatchers: matchers))
        }
        
    }
    
    public struct __VerificationProxy_EKEventStore: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
        
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var eventStoreIdentifier: Cuckoo.VerifyReadOnlyProperty<String> {
            return .init(manager: cuckoo_manager, name: "eventStoreIdentifier", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var delegateSources: Cuckoo.VerifyReadOnlyProperty<[EKSource]> {
            return .init(manager: cuckoo_manager, name: "delegateSources", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var sources: Cuckoo.VerifyReadOnlyProperty<[EKSource]> {
            return .init(manager: cuckoo_manager, name: "sources", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var defaultCalendarForNewEvents: Cuckoo.VerifyReadOnlyProperty<EKCalendar?> {
            return .init(manager: cuckoo_manager, name: "defaultCalendarForNewEvents", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func requestAccess<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(to entityType: M1, completion: M2) -> Cuckoo.__DoNotUse<(EKEntityType, EKEventStoreRequestAccessCompletionHandler), Void> where M1.MatchedType == EKEntityType, M2.MatchedType == EKEventStoreRequestAccessCompletionHandler {
            let matchers: [Cuckoo.ParameterMatcher<(EKEntityType, EKEventStoreRequestAccessCompletionHandler)>] = [wrap(matchable: entityType) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return cuckoo_manager.verify("requestAccess(to: EKEntityType, completion: @escaping EKEventStoreRequestAccessCompletionHandler)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func source<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.__DoNotUse<(String), EKSource?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return cuckoo_manager.verify("source(withIdentifier: String) -> EKSource?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func calendars<M1: Cuckoo.Matchable>(for entityType: M1) -> Cuckoo.__DoNotUse<(EKEntityType), [EKCalendar]> where M1.MatchedType == EKEntityType {
            let matchers: [Cuckoo.ParameterMatcher<(EKEntityType)>] = [wrap(matchable: entityType) { $0 }]
            return cuckoo_manager.verify("calendars(for: EKEntityType) -> [EKCalendar]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func defaultCalendarForNewReminders() -> Cuckoo.__DoNotUse<(), EKCalendar?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("defaultCalendarForNewReminders() -> EKCalendar?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func calendar<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.__DoNotUse<(String), EKCalendar?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return cuckoo_manager.verify("calendar(withIdentifier: String) -> EKCalendar?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func saveCalendar<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ calendar: M1, commit: M2) -> Cuckoo.__DoNotUse<(EKCalendar, Bool), Void> where M1.MatchedType == EKCalendar, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKCalendar, Bool)>] = [wrap(matchable: calendar) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return cuckoo_manager.verify("saveCalendar(_: EKCalendar, commit: Bool) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func removeCalendar<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ calendar: M1, commit: M2) -> Cuckoo.__DoNotUse<(EKCalendar, Bool), Void> where M1.MatchedType == EKCalendar, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKCalendar, Bool)>] = [wrap(matchable: calendar) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return cuckoo_manager.verify("removeCalendar(_: EKCalendar, commit: Bool) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func calendarItem<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.__DoNotUse<(String), EKCalendarItem?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return cuckoo_manager.verify("calendarItem(withIdentifier: String) -> EKCalendarItem?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func calendarItems<M1: Cuckoo.Matchable>(withExternalIdentifier externalIdentifier: M1) -> Cuckoo.__DoNotUse<(String), [EKCalendarItem]> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: externalIdentifier) { $0 }]
            return cuckoo_manager.verify("calendarItems(withExternalIdentifier: String) -> [EKCalendarItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, span: M2) -> Cuckoo.__DoNotUse<(EKEvent, EKSpan), Void> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }]
            return cuckoo_manager.verify("save(_: EKEvent, span: EKSpan) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func remove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, span: M2) -> Cuckoo.__DoNotUse<(EKEvent, EKSpan), Void> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }]
            return cuckoo_manager.verify("remove(_: EKEvent, span: EKSpan) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ event: M1, span: M2, commit: M3) -> Cuckoo.__DoNotUse<(EKEvent, EKSpan, Bool), Void> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan, M3.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan, Bool)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }, wrap(matchable: commit) { $0.2 }]
            return cuckoo_manager.verify("save(_: EKEvent, span: EKSpan, commit: Bool) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func remove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ event: M1, span: M2, commit: M3) -> Cuckoo.__DoNotUse<(EKEvent, EKSpan, Bool), Void> where M1.MatchedType == EKEvent, M2.MatchedType == EKSpan, M3.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKEvent, EKSpan, Bool)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: span) { $0.1 }, wrap(matchable: commit) { $0.2 }]
            return cuckoo_manager.verify("remove(_: EKEvent, span: EKSpan, commit: Bool) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func event<M1: Cuckoo.Matchable>(withIdentifier identifier: M1) -> Cuckoo.__DoNotUse<(String), EKEvent?> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
            return cuckoo_manager.verify("event(withIdentifier: String) -> EKEvent?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func events<M1: Cuckoo.Matchable>(matching predicate: M1) -> Cuckoo.__DoNotUse<(NSPredicate), [EKEvent]> where M1.MatchedType == NSPredicate {
            let matchers: [Cuckoo.ParameterMatcher<(NSPredicate)>] = [wrap(matchable: predicate) { $0 }]
            return cuckoo_manager.verify("events(matching: NSPredicate) -> [EKEvent]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func enumerateEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(matching predicate: M1, using block: M2) -> Cuckoo.__DoNotUse<(NSPredicate, EKEventSearchCallback), Void> where M1.MatchedType == NSPredicate, M2.MatchedType == EKEventSearchCallback {
            let matchers: [Cuckoo.ParameterMatcher<(NSPredicate, EKEventSearchCallback)>] = [wrap(matchable: predicate) { $0.0 }, wrap(matchable: block) { $0.1 }]
            return cuckoo_manager.verify("enumerateEvents(matching: NSPredicate, using: @escaping EKEventSearchCallback)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func predicateForEvents<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(withStart startDate: M1, end endDate: M2, calendars: M3) -> Cuckoo.__DoNotUse<(Date, Date, [EKCalendar]?), NSPredicate> where M1.MatchedType == Date, M2.MatchedType == Date, M3.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<(Date, Date, [EKCalendar]?)>] = [wrap(matchable: startDate) { $0.0 }, wrap(matchable: endDate) { $0.1 }, wrap(matchable: calendars) { $0.2 }]
            return cuckoo_manager.verify("predicateForEvents(withStart: Date, end: Date, calendars: [EKCalendar]?) -> NSPredicate", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ reminder: M1, commit: M2) -> Cuckoo.__DoNotUse<(EKReminder, Bool), Void> where M1.MatchedType == EKReminder, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKReminder, Bool)>] = [wrap(matchable: reminder) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return cuckoo_manager.verify("save(_: EKReminder, commit: Bool) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func remove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ reminder: M1, commit: M2) -> Cuckoo.__DoNotUse<(EKReminder, Bool), Void> where M1.MatchedType == EKReminder, M2.MatchedType == Bool {
            let matchers: [Cuckoo.ParameterMatcher<(EKReminder, Bool)>] = [wrap(matchable: reminder) { $0.0 }, wrap(matchable: commit) { $0.1 }]
            return cuckoo_manager.verify("remove(_: EKReminder, commit: Bool) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func fetchReminders<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(matching predicate: M1, completion: M2) -> Cuckoo.__DoNotUse<(NSPredicate, ([EKReminder]?) -> Void), Any> where M1.MatchedType == NSPredicate, M2.MatchedType == ([EKReminder]?) -> Void {
            let matchers: [Cuckoo.ParameterMatcher<(NSPredicate, ([EKReminder]?) -> Void)>] = [wrap(matchable: predicate) { $0.0 }, wrap(matchable: completion) { $0.1 }]
            return cuckoo_manager.verify("fetchReminders(matching: NSPredicate, completion: @escaping ([EKReminder]?) -> Void) -> Any", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func cancelFetchRequest<M1: Cuckoo.Matchable>(_ fetchIdentifier: M1) -> Cuckoo.__DoNotUse<(Any), Void> where M1.MatchedType == Any {
            let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: fetchIdentifier) { $0 }]
            return cuckoo_manager.verify("cancelFetchRequest(_: Any)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func predicateForReminders<M1: Cuckoo.OptionalMatchable>(in calendars: M1) -> Cuckoo.__DoNotUse<([EKCalendar]?), NSPredicate> where M1.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<([EKCalendar]?)>] = [wrap(matchable: calendars) { $0 }]
            return cuckoo_manager.verify("predicateForReminders(in: [EKCalendar]?) -> NSPredicate", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func predicateForIncompleteReminders<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(withDueDateStarting startDate: M1, ending endDate: M2, calendars: M3) -> Cuckoo.__DoNotUse<(Date?, Date?, [EKCalendar]?), NSPredicate> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, [EKCalendar]?)>] = [wrap(matchable: startDate) { $0.0 }, wrap(matchable: endDate) { $0.1 }, wrap(matchable: calendars) { $0.2 }]
            return cuckoo_manager.verify("predicateForIncompleteReminders(withDueDateStarting: Date?, ending: Date?, calendars: [EKCalendar]?) -> NSPredicate", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func predicateForCompletedReminders<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(withCompletionDateStarting startDate: M1, ending endDate: M2, calendars: M3) -> Cuckoo.__DoNotUse<(Date?, Date?, [EKCalendar]?), NSPredicate> where M1.OptionalMatchedType == Date, M2.OptionalMatchedType == Date, M3.OptionalMatchedType == [EKCalendar] {
            let matchers: [Cuckoo.ParameterMatcher<(Date?, Date?, [EKCalendar]?)>] = [wrap(matchable: startDate) { $0.0 }, wrap(matchable: endDate) { $0.1 }, wrap(matchable: calendars) { $0.2 }]
            return cuckoo_manager.verify("predicateForCompletedReminders(withCompletionDateStarting: Date?, ending: Date?, calendars: [EKCalendar]?) -> NSPredicate", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func commit() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("commit() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func reset() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("reset()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        @discardableResult
        func refreshSourcesIfNecessary() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify("refreshSourcesIfNecessary()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
    }
}

public class EKEventStoreStub: EKEventStore {
    
    
    public override var eventStoreIdentifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public override var delegateSources: [EKSource] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([EKSource]).self)
        }
        
    }
    
    
    public override var sources: [EKSource] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([EKSource]).self)
        }
        
    }
    
    
    public override var defaultCalendarForNewEvents: EKCalendar? {
        get {
            return DefaultValueRegistry.defaultValue(for: (EKCalendar?).self)
        }
        
    }
    
    
    
    
    
    public override  func requestAccess(to entityType: EKEntityType, completion: @escaping EKEventStoreRequestAccessCompletionHandler)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func source(withIdentifier identifier: String) -> EKSource?  {
        return DefaultValueRegistry.defaultValue(for: (EKSource?).self)
    }
    
    public override  func calendars(for entityType: EKEntityType) -> [EKCalendar]  {
        return DefaultValueRegistry.defaultValue(for: ([EKCalendar]).self)
    }
    
    public override  func defaultCalendarForNewReminders() -> EKCalendar?  {
        return DefaultValueRegistry.defaultValue(for: (EKCalendar?).self)
    }
    
    public override  func calendar(withIdentifier identifier: String) -> EKCalendar?  {
        return DefaultValueRegistry.defaultValue(for: (EKCalendar?).self)
    }
    
    public override  func saveCalendar(_ calendar: EKCalendar, commit: Bool) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func removeCalendar(_ calendar: EKCalendar, commit: Bool) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func calendarItem(withIdentifier identifier: String) -> EKCalendarItem?  {
        return DefaultValueRegistry.defaultValue(for: (EKCalendarItem?).self)
    }
    
    public override  func calendarItems(withExternalIdentifier externalIdentifier: String) -> [EKCalendarItem]  {
        return DefaultValueRegistry.defaultValue(for: ([EKCalendarItem]).self)
    }
    
    public override  func save(_ event: EKEvent, span: EKSpan) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func remove(_ event: EKEvent, span: EKSpan) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func save(_ event: EKEvent, span: EKSpan, commit: Bool) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func remove(_ event: EKEvent, span: EKSpan, commit: Bool) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func event(withIdentifier identifier: String) -> EKEvent?  {
        return DefaultValueRegistry.defaultValue(for: (EKEvent?).self)
    }
    
    public override  func events(matching predicate: NSPredicate) -> [EKEvent]  {
        return DefaultValueRegistry.defaultValue(for: ([EKEvent]).self)
    }
    
    public override  func enumerateEvents(matching predicate: NSPredicate, using block: @escaping EKEventSearchCallback)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func predicateForEvents(withStart startDate: Date, end endDate: Date, calendars: [EKCalendar]?) -> NSPredicate  {
        return DefaultValueRegistry.defaultValue(for: (NSPredicate).self)
    }
    
    public override  func save(_ reminder: EKReminder, commit: Bool) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func remove(_ reminder: EKReminder, commit: Bool) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func fetchReminders(matching predicate: NSPredicate, completion: @escaping ([EKReminder]?) -> Void) -> Any  {
        return DefaultValueRegistry.defaultValue(for: (Any).self)
    }
    
    public override  func cancelFetchRequest(_ fetchIdentifier: Any)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func predicateForReminders(in calendars: [EKCalendar]?) -> NSPredicate  {
        return DefaultValueRegistry.defaultValue(for: (NSPredicate).self)
    }
    
    public override  func predicateForIncompleteReminders(withDueDateStarting startDate: Date?, ending endDate: Date?, calendars: [EKCalendar]?) -> NSPredicate  {
        return DefaultValueRegistry.defaultValue(for: (NSPredicate).self)
    }
    
    public override  func predicateForCompletedReminders(withCompletionDateStarting startDate: Date?, ending endDate: Date?, calendars: [EKCalendar]?) -> NSPredicate  {
        return DefaultValueRegistry.defaultValue(for: (NSPredicate).self)
    }
    
    public override  func commit() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func reset()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public override  func refreshSourcesIfNecessary()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

