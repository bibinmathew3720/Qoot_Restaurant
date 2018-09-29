//
//  User.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/27/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit
import CoreData

class User: NSManagedObject {
    
    static func saveUserData(userData:QootLogInResponseModel){
        if let user = User.getUser() {
            updateUserDB(user: user, userData: userData)
        } else {
         let user = CoreDataHandler.sharedInstance.newEntityForName(entityName: "User") as? User
//            user?.refreshToken = userData.refreshToken
//            user?.sessionToken = userData.sessionToken
            updateUserDB(user:user!, userData: userData)
        }
        
    }
    
    class func updateUserDB(user:User,userData:QootLogInResponseModel) {
//        user.userName = userData.userName
          user.email = userData.userEmail
//        user.userPhone = String(userData.userMobile)
//        user.userAddress1 = userData.userAddress1
//        user.userAddress2 = userData.userAddress2
//        user.catId = Int64(userData.catId)
        user.userId = Int16(userData.userId)
//        user.languageId = Int64(userData.languageId)
//        user.locId = Int64(userData.locId)
//        user.dob = userData.userDOB
        CoreDataHandler.sharedInstance.saveContext()
    }
    
    class func getUser() -> User? {
        let detailsArrayPost:NSArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "User") as NSArray
        if (detailsArrayPost.count != 0) {
            return detailsArrayPost.object(at: 0) as? User
        }
        return nil
    }
    
    class func deleteUser() {
        CoreDataHandler.sharedInstance.deleteAllData(name: "User")
        CoreDataHandler.sharedInstance.saveContext()
    }
}
