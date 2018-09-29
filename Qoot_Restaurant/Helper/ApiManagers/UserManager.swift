//
//  UserManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/25/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class UserManager: CLBaseService {
    
    //MARK : Sign Up Api
    
    func callingSignUpApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForRegister(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getRegisterResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForRegister(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+REGISTER_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getRegisterResponseModel(dict:[String : Any?]) -> Any? {
        let loginReponseModel = QootLogInResponseModel.init(dict:dict)
        return loginReponseModel
    }
    
    //MARK : Send OTP Api
    
    func callingSendOTPApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForSendOTP(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.sendOTPResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForSendOTP(with body:String)->CLNetworkModel{
        let sendOTPRequestModel = CLNetworkModel.init(url: BASE_URL+SENDOTP_URL, requestMethod_: "POST")
        sendOTPRequestModel.requestBody = body
        return sendOTPRequestModel
    }
    
    func sendOTPResponseModel(dict:[String : Any?]) -> Any? {
        let sendOTPReponseModel = SendOTPResponseModel.init(dict:dict)
        return sendOTPReponseModel
    }
    
    //MARK : Check OTP Api
    
    func callingCheckOTPApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCheckOTP(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.checkOTPResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCheckOTP(with body:String)->CLNetworkModel{
        let checkOTPRequestModel = CLNetworkModel.init(url: BASE_URL+CHECK_OTP_URL, requestMethod_: "POST")
        checkOTPRequestModel.requestBody = body
        return checkOTPRequestModel
    }
    
    func checkOTPResponseModel(dict:[String : Any?]) -> Any? {
        let checkOTPReponseModel = CheckOTPResponseModel.init(dict:dict)
        return checkOTPReponseModel
    }
    
    //MARK : City Name Api
    
    func callingCityNameApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCityNames(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCityNamesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCityNames(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GETCITYNAMES_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getCityNamesResponseModel(dict:NSArray) -> Any? {
        let cityNamesResponseModel = QootCityNamesResponseModel.init(arr:dict)
        return cityNamesResponseModel
    }
    
    //MARK : MealType Api
    
    func callingViewMealTypeApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForViewMealType(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getViewMealTypeResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForViewMealType(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+VIEWMEALTYPE_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getViewMealTypeResponseModel(dict:NSArray) -> Any? {
        let mealTypeReponseModel = QootMealTypeResponseModel.init(arr:dict)
        return mealTypeReponseModel
    }
    
    //MARK : ViewCuisines Api
    
    func callingViewCuisinesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForViewCuisines(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getViewCuisinesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForViewCuisines(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ViewCuisines_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getViewCuisinesResponseModel(dict:NSArray) -> Any? {
        let viewCuisinesResponseModel = ViewCuisinesResponseModel.init(arr:dict)
        return viewCuisinesResponseModel
    }
    
    //MARK : Kitchens Api
    
    func callingKitchensApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForKitchens(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchensResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForKitchens(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ViewKitchens_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getKitchensResponseModel(dict:NSArray) -> Any? {
        let kitchensResponseModel = KitchensResponseModel.init(arr:dict)
        return kitchensResponseModel
    }
    
  
    //MARK : Log In Api
    
    func callingLogInApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLogIn(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getLogInResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLogIn(with body:String)->CLNetworkModel{
        let loginRequestModel = CLNetworkModel.init(url: BASE_URL+LOGIN_URL, requestMethod_: "POST")
        loginRequestModel.requestBody = body
        return loginRequestModel
    }
    
    func getLogInResponseModel(dict:[String : Any?]) -> Any? {
        let logInReponseModel = QootLogInResponseModel.init(dict:dict)
        return logInReponseModel
    }
    
    //MARK : Get Offer Api
    
    func callingOfferDishesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelOfferDishes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getOfferDishesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelOfferDishes(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+OfferDishes_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getOfferDishesResponseModel(dict:NSArray) -> Any? {
        let offerDishesResponseModel = OfferDishesResponseModel.init(arr:dict)
        return offerDishesResponseModel
    }
    
    //MARK : Get Ready Now Dishes Api
    
    func callingReadyNowDishesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelReadyNowDishes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.readyNowDishesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelReadyNowDishes(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+ReadyNowDishes_URL, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func readyNowDishesResponseModel(dict:NSArray) -> Any? {
        let readyNowDishesResponseModel = ReadyNowDishesResponseModel.init(arr:dict)
        return readyNowDishesResponseModel
    }
    
    //Get Dish Details Api
    
    func callingGetDishDetailsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetDishDetails(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getDishDetailsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetDishDetails(with body:String)->CLNetworkModel{
        let dishDetailsRequestModel = CLNetworkModel.init(url: BASE_URL+DishDetails_URL, requestMethod_: "POST")
        dishDetailsRequestModel.requestBody = body
        return dishDetailsRequestModel
    }
    
    func getDishDetailsResponseModel(dict:[String : Any?]) -> Any? {
        let dishDetailsReponseModel = Dishes.init(dict:dict)
        return dishDetailsReponseModel
    }
    
    //Get Kitchen Details Api
    
    func callingGetKitchenDetailsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetKitchenDetails(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchenDetailsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetKitchenDetails(with body:String)->CLNetworkModel{
        let kitchenDetailsRequestModel = CLNetworkModel.init(url: BASE_URL+KitchenDetails_URL, requestMethod_: "POST")
        kitchenDetailsRequestModel.requestBody = body
        return kitchenDetailsRequestModel
    }
    
    func getKitchenDetailsResponseModel(dict:[String : Any?]) -> Any? {
        let kitchenDetailsReponseModel = ViewKitchens.init(dict:dict)
        return kitchenDetailsReponseModel
    }
    
    func callingGetKitchenInfoApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetKitchenInfo(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchenInfoResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetKitchenInfo(with body:String)->CLNetworkModel{
        let kitchenDetailsRequestModel = CLNetworkModel.init(url: BASE_URL+KitchenInfo_URL, requestMethod_: "POST")
        kitchenDetailsRequestModel.requestBody = body
        return kitchenDetailsRequestModel
    }
    
    func getKitchenInfoResponseModel(dict:NSArray) -> Any? {
        let kitchenDetailsReponseModel = ViewKitchensInfoResponseModel.init(arr:dict)
        return kitchenDetailsReponseModel
    }
    
    func callingGetKitchenAdminRatingApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetKitchenAdminRating(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchenAdminRatingResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetKitchenAdminRating(with body:String)->CLNetworkModel{
        let kitchenDetailsRequestModel = CLNetworkModel.init(url: BASE_URL+KitchenAdminRating_URL, requestMethod_: "POST")
        kitchenDetailsRequestModel.requestBody = body
        return kitchenDetailsRequestModel
    }
    
    func getKitchenAdminRatingResponseModel(dict:[String : Any?]) -> Any? {
        let kitchenDetailsReponseModel = KitchenAdminRatingResponseModel.init(dict:dict)
        return kitchenDetailsReponseModel
    }
    
    func callingGetKitchenCustomerRatingApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetKitchenCustomerRating(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getKitchenCustomerRatingResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetKitchenCustomerRating(with body:String)->CLNetworkModel{
        let kitchenCustomerRatingRequestModel = CLNetworkModel.init(url: BASE_URL+KitchenCustomerRating_URL, requestMethod_: "POST")
        kitchenCustomerRatingRequestModel.requestBody = body
        return kitchenCustomerRatingRequestModel
    }
    
    func getKitchenCustomerRatingResponseModel(dict:NSArray) -> Any? {
        let kitchenCustomerRatingReponseModel = KitchenCustomerRatingsResponseModel.init(arr: dict)
        return kitchenCustomerRatingReponseModel
    }
    
    //MARK : Log Out Api
    
    func callingLogOutApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForLogOut(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getLogOutResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForLogOut(with body:String)->CLNetworkModel{
        let logOutRequestModel = CLNetworkModel.init(url: BASE_URL+LOGOUT_URL, requestMethod_: "POST")
        logOutRequestModel.requestBody = body
        return logOutRequestModel
    }
    
    func getLogOutResponseModel(dict:[String : Any?]) -> Any? {
        let logOutReponseModel = QootLogInResponseModel.init(dict:dict)
        return logOutReponseModel
    }
    //MARK : Edit Profile Api
    
    func callingEditProfileApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForEditProfile(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getEditProfileResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForEditProfile(with body:String)->CLNetworkModel{
        let editProfileRequestModel = CLNetworkModel.init(url: BASE_URL+EDIT_PROFILE_URL, requestMethod_: "POST")
        editProfileRequestModel.requestBody = body
        return editProfileRequestModel
    }
    
    func getEditProfileResponseModel(dict:[String : Any?]) -> Any? {
        let editProfileRequestModel = QootLogInResponseModel.init(dict:dict)
        return editProfileRequestModel
    }
    
    func getProductResponseModel(dict:[String : Any?]) -> Any? {
        let productResponseModel = FetchProductTypeResponseModel.init(dict:dict)
        return productResponseModel
    }
    
    //MARK: ForgotPassword Api
    
    func callingForgotPaswordApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForForgotPassword(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getForgotPasswordResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForForgotPassword(with body:String)->CLNetworkModel{
        let forgotPasswordRequestModel = CLNetworkModel.init(url: BASE_URL+FORGOT_PASS_URL, requestMethod_: "POST")
        forgotPasswordRequestModel.requestBody = body
        return forgotPasswordRequestModel
    }
    
    func getForgotPasswordResponseModel(dict:[String : Any?]) -> Any? {
        let forgotPasswordRequestModel = FetchForgotPasswordResponseModel.init(dict:dict)
        return forgotPasswordRequestModel
    }
    
    //MARK: ChangePassword Api
    
    func callingChangePasswordApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForChangePassword(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getchangetPasswordResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForChangePassword(with body:String)->CLNetworkModel{
        let changePasswordRequestModel = CLNetworkModel.init(url: BASE_URL+CHANGE_PASS_URL, requestMethod_: "POST")
        changePasswordRequestModel.requestBody = body
        return changePasswordRequestModel
    }
    
    func getchangetPasswordResponseModel(dict:[String : Any?]) -> Any? {
        let changePasswordRequestModel = FetchForgotPasswordResponseModel.init(dict:dict)
        return changePasswordRequestModel
    }
    
    //MARK: Get Notifications Api
    
    func callingGetNotificationsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetNotifications(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getNotificationsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetNotifications(with body:String)->CLNetworkModel{
        let getNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+GET_NOTIFICATIONS, requestMethod_: "POST")
        getNotificationsRequestModel.requestBody = body
        return getNotificationsRequestModel
    }
    
    func getNotificationsResponseModel(dict:[String : Any?]) -> Any? {
        let getNotificationsRequestModel = FetchGetNotificationsResponseModel.init(dict:dict)
        return getNotificationsRequestModel
    }
    
    
    //MARK: Get Notifications History Api
    
    func callingGetNotificationHistoryApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetNotificationsHistory(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getNotificationsHistoryResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetNotificationsHistory(with body:String)->CLNetworkModel{
        let getNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+GET_NOTIFICATIONS_HISTORY, requestMethod_: "POST")
        getNotificationsRequestModel.requestBody = body
        return getNotificationsRequestModel
    }
    
    func getNotificationsHistoryResponseModel(dict:[String : Any?]) -> Any? {
        let getNotificationsRequestModel = FetchNotificationsHistoryResponseModel.init(dict:dict)
        return getNotificationsRequestModel
    }
    
    //MARK: Get Notifications Remove Api
    
    func callingNotificationRemoveApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetNotificationsRemove(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getNotificationsRemoveResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetNotificationsRemove(with body:String)->CLNetworkModel{
        let getNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+REMOVE_NOTIFICATIONS, requestMethod_: "POST")
        getNotificationsRequestModel.requestBody = body
        return getNotificationsRequestModel
    }
    
    func getNotificationsRemoveResponseModel(dict:[String : Any?]) -> Any? {
        let getNotificationsRequestModel = FetchNotificationsHistoryResponseModel.init(dict:dict)
        return getNotificationsRequestModel
    }
    
    //MARK: Change Notifications Api
    
    func callingChangeNotificationsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForChangeNotifications(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.changeNotificationsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForChangeNotifications(with body:String)->CLNetworkModel{
        let changeNotificationsRequestModel = CLNetworkModel.init(url: BASE_URL+CHANGE_NOTIFICATIONS, requestMethod_: "POST")
        changeNotificationsRequestModel.requestBody = body
        return changeNotificationsRequestModel
    }
    
    func changeNotificationsResponseModel(dict:[String : Any?]) -> Any? {
        let changeNotificationsRequestModel = FetchChangeNotificationsResponseModel.init(dict:dict)
        return changeNotificationsRequestModel
    }
    
    //MARK: Feedback Api
    
    func callingFeedbackApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForFeedback(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.feedbackResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForFeedback(with body:String)->CLNetworkModel{
        let feedbackRequestModel = CLNetworkModel.init(url: BASE_URL+ADD_FEEDBACK_URL, requestMethod_: "POST")
        feedbackRequestModel.requestBody = body
        return feedbackRequestModel
    }
    
    func feedbackResponseModel(dict:[String : Any?]) -> Any? {
        let feedbackResponseModel = FetchFeedbackResponseModel.init(dict:dict)
        return feedbackResponseModel
    }
    
    
    //MARK: Get All Types
    
    func callingGetAllTypesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAllTypes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProductResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAllTypes(with body:String)->CLNetworkModel{
        let categoriesRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CAT_TYPES, requestMethod_: "POST")
        categoriesRequestModel.requestBody = body
        return categoriesRequestModel
    }
    //MARK: Contact Us Api
    
    func callingContactUsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForContactUs(with: body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.changeContactUsResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForContactUs(with body:String)->CLNetworkModel{
        let contactUsRequestModel = CLNetworkModel.init(url: BASE_URL+CONTACT_US_URL, requestMethod_: "POST")
        contactUsRequestModel.requestBody = body
        return contactUsRequestModel
    }
    
    func changeContactUsResponseModel(dict:[String : Any?]) -> Any? {
        let contactUsReponseModel = FetchContactUsResponseModel.init(dict:dict)
        return contactUsReponseModel
    }
}



class FetchRegister: NSObject {
    var username = ""
    var emailid: String = ""
    var password:String = ""
    var mobile:String = ""
    var dob:String = ""
    var address1:String = ""
    var address2:String = ""
    var languageId:NSNumber = 0
    var platform:NSNumber = 1
    var categories = [NSNumber]()
    var locationId:NSNumber = 0
    
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(emailid as AnyObject, forKey: "u_email")
        dict.updateValue(password as AnyObject, forKey: "u_password")
        dict.updateValue(mobile as AnyObject, forKey: "u_mobile")
        dict.updateValue(dob as AnyObject, forKey: "u_dob")
        dict.updateValue(address1 as AnyObject, forKey: "u_address1")
        dict.updateValue(address2 as AnyObject, forKey: "u_address2")
        if let deviceTok = ApplicationController.deviceToken{
            dict.updateValue(deviceTok as AnyObject, forKey: "device_token")
        } else {
            dict.updateValue("fgdgdgd5667575" as AnyObject, forKey: "device_token")
        }
        dict.updateValue(languageId, forKey: "language_id")
        dict.updateValue(platform, forKey: "u_platform")
        dict.updateValue(categories as AnyObject, forKey: "category_id")
        dict.updateValue(locationId, forKey: "location_id")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}

class QootRegisterResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["session_token"] as? String{
           
        }
        if let value = dict["refresh_token"] as? String{
            
        }
        
    }
}

class FetchLogIn: NSObject {
    var emailid: String = ""
    var password:String = ""
    var platform:NSNumber = 1
    
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(emailid as AnyObject, forKey: "u_email")
        dict.updateValue(password as AnyObject, forKey: "u_password")
        if let deviceTok = ApplicationController.deviceToken{
           dict.updateValue(deviceTok as AnyObject, forKey: "device_token")
        } else {
            dict.updateValue("fgdgdgd5667575" as AnyObject, forKey: "device_token")
        }
        dict.updateValue(platform, forKey: "u_platform")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}


class QootLogInResponseModel : NSObject{
    var statusMessage:String = ""
    var userId:Int = 0
    var userName:String = ""
    var userEmail:String = ""
    var gender:String = ""
    var userMobile:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["message"] as? String{
            statusMessage = value
        }
        if let value = dict["customer_id"] as? String{
            if let userID = Int(value){
                userId = userID
            }
        }
        if let value = dict["customer_name"] as? String{
            userName = value
        }
        if let value = dict["email_id"] as? String{
            userEmail = value
        }
        if let value = dict["customer_gender"] as? String{
            gender = value
        }
        if let value = dict["mobile_number"] as? String{
            gender = value
        }
        
}
}

class SendOTPResponseModel : NSObject{
    var statusMessage:String = ""
    var status:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["Message"] as? String{
            statusMessage = value
        }
        if let value = dict["Status"] as? Int{
            status = value
        }
    }
}

class CheckOTPResponseModel : NSObject{
    var statusMessage:String = ""
    var status:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["message"] as? String{
            statusMessage = value
        }
        if let value = dict["Status"] as? Int{
            status = value
        }
    }
}

class QootCityNamesResponseModel : NSObject{
    var cityNames = [CityName]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                cityNames.append(CityName.init(dict: it ))
            }
        }
    }
}

class CityName : NSObject{
    var cityId:Int = 0
    var cityName:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["city_id"] as? String{
            if let ctyId = Int(value){
               cityId = ctyId
            }
        }
        if let value = dict["city_name"] as? String{
            cityName = value
        }
    }
}


class QootMealTypeResponseModel : NSObject{
    var mealTypes = [MealTypes]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                mealTypes.append(MealTypes.init(dict: it ))
            }
        }
    }
}

class MealTypes : NSObject{
    var catId:Int = 0
    var catName:String = ""
    var categoryIcon:String = ""
    var sort_col:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                catId = catID
            }
        }
        if let value = dict["category_name"] as? String{
            catName = value
        }
        if let value = dict["category_icon"] as? String{
            categoryIcon = value
        }
        if let value = dict["sort_col"] as? Int{
            sort_col = value
        }
    }
}

class KitchensResponseModel : NSObject{
    var viewKitchens = [ViewKitchens]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                viewKitchens.append(ViewKitchens.init(dict: it ))
            }
        }
    }
}

class ViewKitchens : NSObject{
    var KitchenId:Int = 0
    var KitchenName:String = ""
    var KitchenLogo:String = ""
    var KitchenDeliveryFee:Int = 0
    var CutomerRating:Int = 0
    var OpenStatus:Bool = false
    var AdminRating:Int = 0
    
    init(dict:[String:Any?]) {
//        if let value = dict["KitchenId"] as? String{
//            if let kitchenID = Int(value){
//                catId = kitchenID
//            }
//        }
        if let value = dict["KitchenId"] as? Int{
            KitchenId = value
        }
        if let value = dict["KitchenId"] as? String{
            if let kitID = Int(value){
                KitchenId = kitID
            }
        }
        if let value = dict["KitchenName"] as? String{
            KitchenName = value
        }
        if let value = dict["KitchenLogo"] as? String{
            KitchenLogo = value
        }
        if let value = dict["KitchenDeliveryFee"] as? String{
            if let deliveryFee = Int(value){
                KitchenDeliveryFee = deliveryFee
            }
        }
        if let value = dict["CutomerRating"] as? Int{
            CutomerRating = value
        }
        if let value = dict["OpenStatus"] as? Bool{
            OpenStatus = value
        }
        if let value = dict["AdminRating"] as? Int{
            AdminRating = value
        }
    }
}

class ViewKitchensInfoResponseModel : NSObject{
    var kitchensInfo = [ViewKitchensInfo]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                kitchensInfo.append(ViewKitchensInfo.init(dict: it ))
            }
        }
    }
}

class ViewKitchensInfo : NSObject{
    var Delivery:Bool = false
    var Location:String = ""
    var Event:Bool = false
    var QootRating:Int = 0
    var customerRating:Float = 0
    
    init(dict:[String:Any?]) {
        //        if let value = dict["KitchenId"] as? String{
        //            if let kitchenID = Int(value){
        //                catId = kitchenID
        //            }
        //        }
        if let value = dict["Delivery"] as? Bool{
            Delivery = value
        }
        if let value = dict["Location"] as? String{
            Location = value
        }
        
        if let value = dict["Event"] as? Bool{
            Event = value
        }
        if let value = dict["QootRating"] as? Int{
            QootRating = value
        }
        if let value = dict["customerRating"] as? Int{
            customerRating = Float(value)
        }
        if let value = dict["customerRating"] as? Float{
            customerRating = value
        }
    }
}

class KitchenAdminRatingResponseModel : NSObject{
    var kitchen_id:Int = 0
    var kitchen_rating:Float = 0.0
    var money:Float = 0.0
    var packing:Float = 0.0
    var delivery:Float = 0.0
    var quality:Float = 0.0
  
    init(dict:[String:Any?]) {
        if let value = dict["KitchenId"] as? Int{
            kitchen_id = value
        }
        if let value = dict["kitchen_rating"] as? Float{
            kitchen_rating = value
        }
        if let value = dict["money"] as? Float{
            money = value
        }
        if let value = dict["packing"] as? Float{
            packing = value
        }
        if let value = dict["delivery"] as? Float{
            delivery = value
        }
        if let value = dict["quality"] as? Float{
            quality = value
        }
    }
}


class ViewCuisinesResponseModel : NSObject{
    var viewCuisines = [ViewCuisines]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                viewCuisines.append(ViewCuisines.init(dict: it ))
            }
        }
    }
}

class ViewCuisines : NSObject{
    var catId:Int = 0
    var subCatName:String = ""
    var subCatId:Int = 0
    
    init(dict:[String:Any?]) {
        
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                catId = catID
            }
        }
        if let value = dict["sub_category_name"] as? String{
            subCatName = value
        }
        if let value = dict["sub_category_id"] as? String{
            if let sub_catID = Int(value){
                subCatId = sub_catID
            }
        }
    }
}

class FetchForgotPasswordResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class FetchGetNotificationsResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var notificationStatus:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["notification_status"] as? String{
            notificationStatus = value
        }
    }
}

class FetchNotificationsHistoryResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var total:Int = 0
    var data = [FetchNotificationData]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["total"] as? Int{
            total = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                data.append(FetchNotificationData.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchNotificationData : NSObject{
    var id:Int = 0
    var user_id:Int = 0
    var type_id:Int =  0
    var type:String = ""
    var msg_content:String = ""
    var status:String = ""
    var created_date:String = ""
    var updated_date:String = ""
    var img_url:String = ""

    init(dict:[String:Any?]) {
        if let value = dict["id"] as? Int{
            id = value
        }

        if let value = dict["user_id"] as? Int{
            user_id = value
        }
        if let value = dict["type_id"] as? Int{
            type_id = value
        }
        if let value = dict["type"] as? String{
            type = value
        }
        if let value = dict["msg_content"] as? String{
            msg_content = value
        }
        if let value = dict["status"] as? String{
            status = value
        }
        if let value = dict["created_at"] as? String{
            created_date = value
        }
        if let value = dict["updated_at"] as? String{
            updated_date = value
        }
        if let value = dict["img_url"] as? String{
            img_url = value
        }
    }
}

class FetchChangeNotificationsResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class FetchContactUsResponseModel: NSObject {
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class FetchContactUsRequestModel: NSObject {
    var email: String = ""
    var name:String = ""
    var message:String = ""
    func getRequestBody()->String{
        var dict:[String:AnyObject] = [String:AnyObject]()
        dict.updateValue(email as AnyObject, forKey: "u_email")
        dict.updateValue(name as AnyObject, forKey: "u_name")
        dict.updateValue(message as AnyObject, forKey: "u_message")
//        if let user = User.getUser() {
//            dict.updateValue(String(user.userId) as AnyObject , forKey: "user_id")
//        }
        let languageString = L102Language.currentAppleLanguage()
        var languageId:NSNumber = 1
        if (languageString == "ar"){
            languageId = 2
        }
        dict.updateValue(languageId.stringValue as AnyObject, forKey: "language_id")
        return CCUtility.getJSONfrom(dictionary: dict)
    }
}
class FetchProductTypeResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var productType = [FetchProductType]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                productType.append(FetchProductType.init(dict: item as! [String : Any?]))
            }
        }
        
        
    }
}

class FetchProductType :NSObject {
    var type_id:Int = 0
    var typeName:String = ""
    var type_pic:String = ""
    var created_date:String = ""
    var last_updated_date:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["type_id"] as? Int{
            type_id = value
        }
        if let value = dict["typeName"] as? String{
            typeName = value
        }
        if let value = dict["type_pic"] as? String{
            type_pic = value
        }
        if let value = dict["created_date"] as? String{
            created_date = value
        }
        if let value = dict["last_updated_date"] as? String{
            last_updated_date = value
        }
    }
}

class FetchFeedbackResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
    }
}

class OfferDishesResponseModel : NSObject{
    var dishes = [Dishes]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                dishes.append(Dishes.init(dict: it ))
            }
        }
    }
}

class ReadyNowDishesResponseModel : NSObject{
    var dishes = [Dishes]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                dishes.append(Dishes.init(dict: it ))
            }
        }
    }
}

class Dishes : NSObject{
    var DishAmount:Float = 0.0
    var DishCategory:Int = 0
    var DishDescription:String = ""
    var DishId:Int = 0
    var DishImage:String = ""
    var DishMainCategory:Int = 0
    var DishName:String = ""
    var DishQuantity:String = "'"
    var DishServe:Int = 0
    var DishTime:String = ""
    var KitchenId:Int = 0
    var MenuId:Int = 0
    var SelectedQuantity:Int = 1
    
    
    var OrderName:String = ""
    var OrderQuantity:Int = 0
    var OrderAmount:Float = 0.0
    init(dict:[String:Any?]) {
        //        if let value = dict["KitchenId"] as? String{
        //            if let kitchenID = Int(value){
        //                catId = kitchenID
        //            }
        //        }
        if let value = dict["DishAmount"] as? Float{
            DishAmount = value
        }
        if let value = dict["DishCategory"] as? String{
            if let dishCategory = Int(value){
                DishCategory = dishCategory
            }
        }
        if let value = dict["DishDescription"] as? String{
            DishDescription = value
        }
        if let value = dict["DishId"] as? Int{
            DishId = value
        }
        if let value = dict["DishId"] as? String{
            print(value)
            //DishId = value
        }
        if let value = dict["DishImage"] as? String{
            DishImage = value
        }
        if let value = dict["DishMainCategory"] as? String{
            if let dishMainCategory = Int(value){
                DishMainCategory = dishMainCategory
            }
        }
        if let value = dict["DishName"] as? String{
            DishName = value
        }
        if let value = dict["DishQuantity"] as? String{
                DishQuantity = value
        }
        if let value = dict["DishServe"] as? String{
            if let dishServe = Int(value){
                DishServe = dishServe
            }
        }
        if let value = dict["DishTime"] as? String{
            DishTime = value
        }
        if let value = dict["KitchenId"] as? Int{
            KitchenId = value
        }
        if let value = dict["MenuId"] as? Int{
            MenuId = value
        }
        
        //For Order
        
        if let value = dict["order_name"] as? String{
            OrderName = value
        }
        if let value = dict["order_quantity"] as? String{
            if let orderQuantity = Int(value){
                OrderQuantity = orderQuantity
            }
        }
        if let value = dict["order_amount"] as? Float{
            OrderAmount = value
        }
        
    }
}
    class KitchenCustomerRatingsResponseModel : NSObject{
        var customerRating = [KitchenCustomerRating]()
        init(arr:(NSArray)) {
            for item in arr{
                if let it = item as? [String : Any?]{
                    customerRating.append(KitchenCustomerRating.init(dict: it ))
                }
            }
        }
    }

    class KitchenCustomerRating : NSObject{
        var customerRating:Int = 0
        var ratingId:String = ""
        var customerName:String = ""
        var customerComment:String = ""
        var customerDate:String = ""
        init(dict:[String:Any?]) {
            if let value = dict["CustomerRating"] as? String{
                if let ctyId = Int(value){
                    customerRating = ctyId
                }
            }
            if let value = dict["CustomerRating"] as? Int{
                customerRating = value
            }
            if let value = dict["RatingId"] as? String{
                ratingId = value
            }
            if let value = dict["CustomerName"] as? String{
                customerName = value
            }
            if let value = dict["CustomerComment"] as? String{
                customerComment = value
            }
            if let value = dict["CustomerDate"] as? String{
                customerDate = value
            }
        }
    }
