//
//  EKEventError.swift
//  EmployeeRoster
//
//  Created by Nischal Hada on 13/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

enum EKEventError: Error {
    case calendarAccessDeniedOrRestricted
    case eventNotAddedToCalendar
    case eventAlreadyExistsInCalendar
}

extension EKEventError: LocalizedError {
    /// A localized message describing what error occurred.
    /// Also the title in alert view errors in EmployeeRoster
    public var errorDescription: String? {
        switch self {
        case .calendarAccessDeniedOrRestricted:
            return "Calendar access denied or restricted"
        case .eventNotAddedToCalendar:
            return "Unable to add event to Calendar"
        case .eventAlreadyExistsInCalendar:
            return "Event already exists in Calendar"
        }
    }

    /// A localized message describing how one might recover from the failure.
    /// Also the message in alert view errors in EmployeeRoster
    public var recoverySuggestion: String? {
        switch self {
        case .calendarAccessDeniedOrRestricted:
            return "Allow Calendar access to use this features"
        case .eventNotAddedToCalendar:
            return "Unable to add event to Calendar, Allow Calendar access"
        case .eventAlreadyExistsInCalendar:
            return "Event already exists in Calendar, Please create new event"
        }
    }
}
