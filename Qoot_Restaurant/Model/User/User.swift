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
            updateUserDB(user:user!, userData: userData)
        }
        
    }
    
    class func updateUserDB(user:User,userData:QootLogInResponseModel) {
        user.mroofNumber = Int64(userData.mroofNumber)
        user.customerPhoto = userData.customerPhoto
        user.mobNumber = userData.userMobile
        user.kitchenCity = userData.kitchenCity
        user.kitchenMapLocation = userData.kitchenMapLocation
        user.customerName = userData.userName
        user.email = userData.userEmail
        user.deliveryFee = userData.deliveryFee
        user.kitchenName = userData.kitchenName
        user.kitchenAddress = userData.kitchenAddress
        user.kitchenLocation = userData.kitchenLocation
        user.kitchenId = userData.kitchenId
        user.instagramPage = userData.kitchenInstagramPage
        CoreDataHandler.sharedInstance.saveContext()
    }
    
    class func getUser() -> User? {
        let detailsArrayPost:NSArray = CoreDataHandler.sharedInstance.getAllDatas(entity: "User") as NSArray
        if (detailsArrayPost.count != 0) {
            return detailsArrayPost.object(at: 0) as? User
        }
        return nil
    }
    
    class func updateProfileImage(updateProfileImageResponse:UploadProfileImageResponse) {
        if let user = User.getUser() {
            user.customerPhoto = updateProfileImageResponse.customer_photo
            CoreDataHandler.sharedInstance.saveContext()
        }
        
    }
    
    class func deleteUser() {
        CoreDataHandler.sharedInstance.deleteAllData(name: "User")
        CoreDataHandler.sharedInstance.saveContext()
    }
}
