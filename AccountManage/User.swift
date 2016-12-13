//
//  User.swift
//  Often
//
//  Created by Kervins Valcourt on 5/13/15.
//  Copyright (c) 2015 Project Surf. All rights reserved.
//
import UIKit

class User: NSObject {
    var id: String = ""
    var isNew: Bool = false
    var name: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var username: String = ""
    var profileImageSmall: String = ""
    var profileImageLarge: String = ""
    var email: String = ""
    var phone: String = ""
    var password: String = ""
    var backgroundImage: String = ""
    var favoritesPackId: String = ""
    var recentsPackId: String = ""
    var shareCount: Int = 0
    var followersCount: Int = 0
    var followingCount: Int = 0
    var pushNotificationStatus: Bool = false
    var firebasePushNotificationToken: String = ""

    override func setValuesForKeys(_ data: [String : Any]) {

        if let nameString = data["displayName"] as? String {
            name = nameString
        }
        
        if let nameString = data["name"] as? String {
            name = nameString
        }

        if let firstNameString = data["first_name"] as? String {
            firstName = firstNameString
        }

        if let lastNameString = data["last_name"] as? String {
            lastName = lastNameString
        }
        
        if let usernameString = data["username"] as? String {
            username = usernameString
        }
        
        if let idString = data["id"] as? String {
            id = idString
        }
        
        if let emailString = data["email"] as? String {
            email = emailString
        }

        if let backgroundImageString =  data["backgroundImage"] as? String {
            backgroundImage = backgroundImageString
        }

        if let profileImageSmallString = data["profileImageSmall"] as? String {
            profileImageSmall = profileImageSmallString
        }

        if let profileImageLargeString = data["profileImageLarge"] as? String {
            profileImageLarge = profileImageLargeString
        }

        if let phoneString = data["phone"] as? String {
            phone = phoneString
        }

        if let favsId = data["favoritesPackId"] as? String {
            favoritesPackId = favsId
        }

        if let recentsId = data["recentsPackId"] as? String {
            recentsPackId = recentsId
        }

        if let shareCount = data["shareCount"] as? Int {
            self.shareCount = shareCount
        }

        if let followersCount = data["followersCount"] as? Int {
            self.followersCount = followersCount
        }

        if let followingCount = data["followingCount"] as? Int {
            self.followingCount = followingCount
        }

        if let pushNotificationStatus = data["pushNotificationStatus"] as? Bool {
            self.pushNotificationStatus = pushNotificationStatus
            SessionManagerFlags.defaultManagerFlags.userNotificationSettings = pushNotificationStatus
        }

        if let firebasePushNotificationToken = data["firebasePushNotificationToken"] as? String {
            self.firebasePushNotificationToken = firebasePushNotificationToken
        }

    }
    
    func dataChangedToDictionary() -> [String: AnyObject] {
        var userData: [String: AnyObject] = [
            "id": id as AnyObject,
            "name": name as AnyObject,
            "first_name": firstName as AnyObject,
            "last_name": lastName as AnyObject,
            "username": username as AnyObject,
            "profileImageSmall": profileImageSmall as AnyObject,
            "profileImageLarge": profileImageLarge as AnyObject,
            "backgroundImage": backgroundImage as AnyObject
        ]

        if !email.isEmpty {
            userData["email"] = email as AnyObject?
        }

        if !favoritesPackId.isEmpty {
            userData["favoritesPackId"] = favoritesPackId as AnyObject?
        }

        if !recentsPackId.isEmpty {
            userData["recentsPackId"] = recentsPackId as AnyObject?
        }

        return userData
    }

}

struct UserAuthData {
    var name: String
    var email: String
    var password: String
    var isNewUser: Bool
}
