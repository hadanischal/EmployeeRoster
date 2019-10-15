//
//  EKEventHelper.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 13/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import EventKit

protocol EKEventHelperDataSource {
    var authorizationStatus: Single<EKEventHelperStatus> { get }
    var requestAccess: Single<Bool> { get }
}

struct EKEventHelper: EKEventHelperDataSource {

    var eventStore: EKEventStore!

    init() {
        eventStore = EKEventStore()
    }

    // Get Calendar auth status
    var authorizationStatus: Single<EKEventHelperStatus> {
        return Single<EKEventHelperStatus>.create { single in
            let authStatus = self.getAuthorizationStatus()
            switch authStatus {
            case .notDetermined:
                single(.success(.notDetermined))
            case .authorized:
                single(.success(.authorized))
            case .restricted:
                single(.success(.restricted))
            case .denied:
                single(.success( .denied))
            @unknown default:
                single(.error(RxError.unknown))
                fatalError("EKEventStore.authorizationStatus() is not available on this version of OS.")
            }
            return Disposables.create()
        }
    }

    // Request access to the Calendar
    var requestAccess: Single<Bool> {
        return Single<Bool>.create { single in
            self.eventStore.requestAccess(to: EKEntityType.event) { (authorizationStatus, error) in
                if let error = error {
                    single(.error(error))
                }
                single(.success(authorizationStatus))
            }
            return Disposables.create()
        }
    }

    // Get Calendar auth status
    private func getAuthorizationStatus() -> EKAuthorizationStatus {
        return EKEventStore.authorizationStatus(for: EKEntityType.event)
    }
}
