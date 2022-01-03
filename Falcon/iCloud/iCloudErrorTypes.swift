//
//  iCloudErrorTypes.swift
//  Falcon
//
//  Created by Gokul Nair on 03/01/22.
//

import Foundation

enum CloudKitError: String {
    case AccountNotFound = "iCloud Account not found"
    case AccountNotDetermined = "iCloud Account not determined"
    case AccountRestricted = "iCloud Account restricted"
    case AccountUnknown = "iCloud Account is facing some issue to connect"
    case AccountTemporarilyUnavailable = "iCloud Account temporarily unavailable"
}
