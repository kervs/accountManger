//
//  AccountManager.swift
//  Often
//
//  Created by Kervins Valcourt on 1/11/16.
//  Copyright © 2016 Surf Inc. All rights reserved.
//

import Foundation
import Alamofire
import Firebase

typealias AccountManagerResultCallback = (_ results: ResultType) -> Void

class AccountManager: AccountManagerProtocol {
    weak var delegate: AccountManagerDelegate?
    var currentUser: User?

    final internal var sessionManagerFlags: SessionManagerFlags = SessionManagerFlags.defaultManagerFlags
    internal var userRef: FIRDatabaseReference?
    internal var firebase: FIRDatabaseReference
    internal var isNetworkReachable: Bool = true

    required init (firebase: FIRDatabaseReference) {
        self.firebase = firebase
    }

    func isUserLoggedIn() {
        guard let userID = sessionManagerFlags.userId else {
            delegate?.accountManagerNoUserFound(self)
            return
        }

        userRef = firebase.child("users/\(userID)")
        userRef?.observe(.value, with: { snapshot in
            if let value = snapshot.value as? [String: AnyObject] , snapshot.exists() {
                self.currentUser = User()
                self.currentUser?.setValuesForKeys(value)
                if let currentUser = self.currentUser {
                    self.delegate?.accountManagerUserDidLogin(self, user: currentUser)
                }

            } else {
                self.delegate?.accountManagerNoUserFound(self)
            }
        })
    }

    func login(_ userData: UserAuthData?, completion: AccountManagerResultCallback) {
        fatalError("login method must be overridden in every child class")
    }

    func logout() {
        currentUser = nil
    }

    func initiateUserWithPacks() {
        guard let user = currentUser else {
            return
        }

        let userQueue = FIRDatabase.database().reference().child("queues/user/tasks").childByAutoId()
        userQueue.setValue([
            "userId": user.id,
            "type": "initiatePacks"
            ])
    }

    internal func openSession(_ completion: @escaping AccountManagerResultCallback) {}
    internal func fetchUserData(_ authData: FIRUser, completion: @escaping AccountManagerResultCallback) {}
}

enum AccountManagerError: Error {
    case missingUserData
    case returnedEmptyUserObject
    case notConnectedOnline
}
