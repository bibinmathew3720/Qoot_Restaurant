//
//  UserManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/25/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class UserManager: CLBaseService {
    
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
    
    //MARK : Dashboard Api
    
    func callingDashboardApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForDashboard(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getDashboardResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForDashboard(with body:String)->CLNetworkModel{
        let dashboardRequestModel = CLNetworkModel.init(url: BASE_URL+DASHBOARD_URL, requestMethod_: "POST")
        dashboardRequestModel.requestBody = body
        return dashboardRequestModel
    }
    
    func getDashboardResponseModel(dict:[String : Any?]) -> Any? {
        let dashboardReponseModel = DashboardResponseModel.init(dict:dict)
        return dashboardReponseModel
    }
    
    //MARK : Update Online Status Api
    
    func callingUpdateOnlineStatusApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForOnlineStatus(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getUpdateOnlineStatusResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForOnlineStatus(with body:String)->CLNetworkModel{
        let dashboardRequestModel = CLNetworkModel.init(url: BASE_URL+UPDATE_ONLINESTATUS_URL, requestMethod_: "POST")
        dashboardRequestModel.requestBody = body
        return dashboardRequestModel
    }
    
    func getUpdateOnlineStatusResponseModel(dict:[String : Any?]) -> Any? {
        let statusReponseModel = UpdateOnlineStatusResponseModel.init(dict:dict)
        return statusReponseModel
    }
    
    //MARK : View Online Status Api
    
    func callingViewlineStatusApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForViewOnlineStatus(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getUpdateOnlineStatusResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForViewOnlineStatus(with body:String)->CLNetworkModel{
        let dashboardRequestModel = CLNetworkModel.init(url: BASE_URL+VIEW_ONLINESTATUS_URL, requestMethod_: "POST")
        dashboardRequestModel.requestBody = body
        return dashboardRequestModel
    }
    
    //MARK : Get Categories Api
    
    func callingGetCategoriesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetCategories(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCategoriesResponseModel(categoryArray: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetCategories(with body:String)->CLNetworkModel{
        let getCategoriesRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CATEGORIES_URL, requestMethod_: "POST")
        getCategoriesRequestModel.requestBody = body
        return getCategoriesRequestModel
    }
    
    func getCategoriesResponseModel(categoryArray:NSArray) -> Any? {
        let categoryReponseModel = QootCategoriesResponseModel.init(arr:categoryArray)
        return categoryReponseModel
    }
    
    //MARK : Get Preparation Times Api
    
    func callingGetPreparationTimesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetPreparationTimes(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getPreparationTimesResponseModel(prepTimesArray: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetPreparationTimes(with body:String)->CLNetworkModel{
        let preparationTimesRequestModel = CLNetworkModel.init(url: BASE_URL+GET_PREPARATIONTIMES_URL, requestMethod_: "POST")
        preparationTimesRequestModel.requestBody = body
        return preparationTimesRequestModel
    }
    
    func getPreparationTimesResponseModel(prepTimesArray:NSArray) -> Any? {
        let prepTimeReponseModel = PreparationTimesResponseModel.init(arr:prepTimesArray)
        return prepTimeReponseModel
    }
    
    //MARK : Add New Dish Api
    
    func callingAddNewDishApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAddNewDish(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.addNewDishResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAddNewDish(with body:String)->CLNetworkModel{
        let addNewDishRequestModel = CLNetworkModel.init(url: BASE_URL+GET_PREPARATIONTIMES_URL, requestMethod_: "POST")
        addNewDishRequestModel.requestBody = body
        return addNewDishRequestModel
    }
    
    func addNewDishResponseModel(dict:[String : Any?]) -> Any? {
        let addNewDishReponseModel = AddNewDishResponse.init(dict:dict)
        return addNewDishReponseModel
    }
    
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
    
}

class QootLogInResponseModel : NSObject{
    var mroofNumber:Int = 0
    var customerPhoto:String = ""
    var userMobile:String = ""
    var kitchenCity:String = ""
    var kitchenMapLocation = ""
    var userName:String = ""
    var kitchenId:Int = 0
    var userEmail:String = ""
    var deliveryFee:Float = 0.0
    var kitchenName:String = ""
    var kitchenAddress:String = ""
    var kitchenLocation:String = ""
    var statusMessage:String = ""
    
    init(dict:[String:Any?]) {
        if let value = dict["maroof_number"] as? String{
            if let mrfNumber = Int(value){
                mroofNumber = mrfNumber
            }
        }
        if let value = dict["customer_photo"] as? String{
            customerPhoto = value
        }
        if let value = dict["kitchen_city"] as? String{
            kitchenCity = value
        }
        if let value = dict["kitchen_map_location"] as? String{
            kitchenMapLocation = value
        }
        if let value = dict["customer_name"] as? String{
            userName = value
        }
        if let value = dict["message"] as? String{
            statusMessage = value
        }
        if let value = dict["customer_id"] as? String{
            if let userID = Int(value){
                kitchenId = userID
            }
        }
        if let value = dict["email_id"] as? String{
            userEmail = value
        }
        if let value = dict["kitchen_delivery_fee"] as? String{
            if let delFee = Float(value){
                deliveryFee = delFee
            }
        }
        if let value = dict["kitchen_name"] as? String{
            kitchenName = value
        }
        if let value = dict["kitchen_address"] as? String{
            kitchenAddress = value
        }
        if let value = dict["kitchen_location"] as? String{
            kitchenLocation = value
        }
        if let value = dict["mobile_number"] as? String{
            userMobile = value
        }
    }
}

class DashboardResponseModel : NSObject{
    var todayEarn:Float = 0.0
    var qootBalance:Float = 0.0
    var totalVisitors:Int = 0
    var visitorsOnline:Int = 0
    
    init(dict:[String:Any?]) {
        if let value = dict["TodayEarn"] as? Int{
                todayEarn = Float(value)
        }
        if let value = dict["QootBalance"] as? Int{
                qootBalance = Float(value)
        }
        if let value = dict["TotalVisitors"] as? Int{
           totalVisitors = value
        }
        if let value = dict["VisitorsOnline"] as? Int{
            visitorsOnline = value
        }
    }
}

class UpdateOnlineStatusResponseModel : NSObject{
    var onlineStatus:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["Status"] as? String{
            if let status = Int(value){
                onlineStatus = status
            }
        }
    }
}

class QootCategoriesResponseModel : NSObject{
    var categories = [Categories]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                categories.append(Categories.init(dict: it ))
            }
        }
    }
}

class Categories : NSObject{
    var categoryId:Int = 0
    var categoryName:String = ""
    var subCategories = [SubCategory]()
    init(dict:[String:Any?]) {
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                categoryId = catID
            }
        }
        if let value = dict["category_name"] as? String{
                categoryName = value
        }
        if let subCatArray = dict["sub_category"] as? NSArray {
            for subCat in subCatArray {
                subCategories.append(SubCategory.init(dict: subCat as! [String : Any?]))
            }
        }
    }
}

class SubCategory : NSObject{
    var categoryId:Int = 0
    var categoryName:String = ""
    var subCatIId:Int = 0
    var subCatName:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                categoryId = catID
            }
        }
        if let value = dict["category_name"] as? String{
            categoryName = value
        }
        if let value = dict["sub_category_id"] as? String{
            if let subID = Int(value){
                subCatIId = subID
            }
        }
        if let value = dict["sub_category_name"] as? String{
            subCatName = value
        }
    }
}

class PreparationTimesResponseModel : NSObject{
    var prepTimes = [PreparationTime]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                prepTimes.append(PreparationTime.init(dict: it ))
            }
        }
    }
}

class PreparationTime : NSObject{
    var time:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["time"] as? String{
            time = value
        }
    }
}

class AddNewDishResponse : NSObject{
    var categoryId:Int = 0
    var categoryName:String = ""
    var subCategories = [SubCategory]()
    init(dict:[String:Any?]) {
        if let value = dict["category_id"] as? String{
            if let catID = Int(value){
                categoryId = catID
            }
        }
        if let value = dict["category_name"] as? String{
            categoryName = value
        }
        if let subCatArray = dict["sub_category"] as? NSArray {
            for subCat in subCatArray {
                subCategories.append(SubCategory.init(dict: subCat as! [String : Any?]))
            }
        }
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
