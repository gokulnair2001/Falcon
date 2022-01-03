//
//  UserSetup.swift
//  Falcon
//
//  Created by Gokul Nair on 03/01/22.
//

import CloudKit
import SwiftUI

class CloudKitUserSetupViewModel: ObservableObject {
    
    @Published var isiCloudPermitted: Bool = false
    @Published var isSignedIn: Bool = false
    @Published var statusTag: String = "Text"
    @Published var userName: String = ""
    
    let CKDefaultContainer = CKContainer.default()
    
    init() {
        getiCloudStatus()
        requestPermission()
    }
    
    // Function to get iCloud Status
    private func getiCloudStatus() {
        CKDefaultContainer.accountStatus { returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .couldNotDetermine:
                    self.statusTag = CloudKitError.AccountNotDetermined.rawValue
                case .available:
                    self.isSignedIn = true
                    self.statusTag = "available"
                case .restricted:
                    self.statusTag = CloudKitError.AccountRestricted.rawValue
                case .noAccount:
                    self.statusTag = CloudKitError.AccountNotFound.rawValue
                case .temporarilyUnavailable:
                    self.statusTag = CloudKitError.AccountTemporarilyUnavailable.rawValue
                default:
                    self.statusTag = CloudKitError.AccountUnknown.rawValue
                }
            }
        }
    }
    
    // Function to ask user permission for enabling iCloud
    func requestPermission() {
        CKDefaultContainer.requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.isiCloudPermitted = true
                    self?.fetchiCloudUserRecordID()
                }else if returnedStatus == .denied {
                    // deal with the edge case when user doesn't allows iCloud
                    self?.isiCloudPermitted = false
                }
            }
        }
    }
    
    // Function to fetch user record ID
    func fetchiCloudUserRecordID() {
        CKDefaultContainer.fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    // Function to fetch user details
    func discoveriCloudUser(id: CKRecord.ID) {
        CKDefaultContainer.discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let firstName = returnedIdentity?.nameComponents?.givenName, let lastName = returnedIdentity?.nameComponents?.familyName{
                    self?.userName = "\(firstName) \(lastName)"
                }
            }
        }
    }
}
