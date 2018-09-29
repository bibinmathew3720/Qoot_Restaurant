//
//  CartManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 7/5/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class CartManager: CLBaseService {
    
    //MARK: Order List Api
    
    func callingGetOrderListApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForOrderList(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getOrderHistoryResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForOrderList(with body:String)->CLNetworkModel{
        let orderListRequestModel = CLNetworkModel.init(url: BASE_URL+CustomerOrderHistory_URL, requestMethod_: "POST")
        orderListRequestModel.requestBody = body
        return orderListRequestModel
    }
    
    func getOrderHistoryResponseModel(dict:NSArray) -> Any? {
        let orderHistoryResponseModel = QootOrderHistoryResponseModel.init(history:dict)
        return orderHistoryResponseModel
    }
   
   
    //MARK: CheckOut Api
    
    func callingCheckOutApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForCheckOut(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCheckOutResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForCheckOut(with body:String)->CLNetworkModel{
        let checkOutRequestModel = CLNetworkModel.init(url: BASE_URL+CHECK_OUT_URL, requestMethod_: "POST")
        checkOutRequestModel.requestBody = body
        return checkOutRequestModel
    }
    func getCheckOutResponseModel(dict:[String : Any?]) -> Any? {
        let checkOutRequestModel = CheckOutResponseModel.init(dict:dict)
        return checkOutRequestModel
    }
    
    //MARK: Get CouponCode Api
    
    func callingCouponCodeApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelCouponCode(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getCouponCodeResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelCouponCode(with body:String)->CLNetworkModel{
        let CouponCodeRequestModel = CLNetworkModel.init(url: BASE_URL+GET_COUPON_CODE, requestMethod_: "POST")
        CouponCodeRequestModel.requestBody = body
        return CouponCodeRequestModel
    }
    func getCouponCodeResponseModel(dict:[String : Any?]) -> Any? {
        let CouponCodeRequestModel = CouponCodeResponseModel.init(dict:dict)
        return CouponCodeRequestModel
    }
    
    
    //MARK: Calling Payment Api
    
    func callingPaymentApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForPayment(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getPaymentResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForPayment(with body:String)->CLNetworkModel{
        let CouponCodeRequestModel = CLNetworkModel.init(url: BASE_URL+PAYMENT_URL, requestMethod_: "POST")
        CouponCodeRequestModel.requestBody = body
        return CouponCodeRequestModel
    }
    
    func getPaymentResponseModel(dict:[String : Any?]) -> Any? {
        let paymentResponseModel = PaymentResponseModel.init(dict:dict)
        return paymentResponseModel
    }
    
    //MARK: Get Delivery Addresses Api
    
    func callingGetAddressessApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForGetAllAddresses(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveArrayResponseSuccessFully(resultData)
            
            
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getAllAddressesResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForGetAllAddresses(with body:String)->CLNetworkModel{
        let addressRequestModel = CLNetworkModel.init(url: BASE_URL+GetAllAddresses_URL, requestMethod_: "POST")
        addressRequestModel.requestBody = body
        return addressRequestModel
    }
    
    func getAllAddressesResponseModel(dict:NSArray) -> Any? {
        let addressesResponseModel = AddressResponseModel.init(arr:dict)
        return addressesResponseModel
    }
    
    //MARK: Add Customer Delivery Addresse Api
    
    func callingAddCustomerAddressApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAddCustomerAddress(with:body), success: {
            (resultData) in
             let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.addAddressResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAddCustomerAddress(with body:String)->CLNetworkModel{
        let addressRequestModel = CLNetworkModel.init(url: BASE_URL+AddCustomerAddress_URL, requestMethod_: "POST")
        addressRequestModel.requestBody = body
        return addressRequestModel
    }
    
    func addAddressResponseModel(dict:[String : Any?]) -> Any? {
        let addAddressesResponseModel = AddAddressResponseModel.init(dict:dict)
        return addAddressesResponseModel
    }
    
    //MARK: Remove Customer Addresse Api
    
    func callingRemoveCustomerAddressApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForRemoveCustomerAddress(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.removeAddressResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForRemoveCustomerAddress(with body:String)->CLNetworkModel{
        let addressRequestModel = CLNetworkModel.init(url: BASE_URL+RemoveCustomerAddress_URL, requestMethod_: "POST")
        addressRequestModel.requestBody = body
        return addressRequestModel
    }
    
    func removeAddressResponseModel(dict:[String : Any?]) -> Any? {
        let removeAddressesResponseModel = RemoveAddressResponseModel.init(dict:dict)
        return removeAddressesResponseModel
    }
   
    
    //MARK: Add Customer Order Api
    
    func addCustomerOrderApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAddCustomerOrder(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict as Any)
                    success(self.addCustomerOrderResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
        }, failiure: {(error)-> () in failure(error)
            
        })
    }
    
    func networkModelForAddCustomerOrder(with body:String)->CLNetworkModel{
        let addressRequestModel = CLNetworkModel.init(url: BASE_URL+AddCustomerOrder_URL, requestMethod_: "POST")
        addressRequestModel.requestBody = body
        return addressRequestModel
    }
    
    func addCustomerOrderResponseModel(dict:[String : Any?]) -> Any? {
        let addressesResponseModel = AddCustomerOrderResponseModel.init(dict:dict)
        return addressesResponseModel
    }
}

class CheckOutResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var purchase_Id:Int = 0
    var user_Id:Int = 0
    var deliveryCharge:Double = 0
    var deleveryDate:String = ""
    var totalAmount:Double = 0
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
        if let value = dict["purchase_id"] as? Int{
            purchase_Id = value
        }
        if let value = dict["user_id"] as? Int{
            user_Id = value
        }
        if let value = dict["delivery_charge"] as? Double{
            deliveryCharge = value
        }
        if let value = dict["total_amount"] as? Double{
            totalAmount = value
        }
        if let value = dict["delivery_date"] as? String{
            deleveryDate = value
        }
    }
}


class AddCustomerOrderResponseModel : NSObject{
    var statusMessage:String = ""
    var statusCode:Int = 0
    var order_Id:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["orderid"] as? Int{
            order_Id = value
        }
    }
}

class CouponCodeResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var discount:Double = 0
    var grandTotalAmount:Double = 0
    // var product:FetchProduct?
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
        if let value = dict["grandTotal"] as? Double{
            grandTotalAmount = value
        }
        if let value = dict["discount"] as? Double{
            discount = value
        }
    }
}

class PaymentResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var paymentUrl:String = ""
    var paymentMode:String = ""
    // var product:FetchProduct?
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
        if let value = dict["paymentUrl"] as? String{
            paymentUrl = value
        }
        if let value = dict["paymode"] as? String{
            paymentMode = value
        }
      
    }
}

class AddressResponseModel : NSObject{
    var addresses = [Address]()
    init(arr:(NSArray)) {
        for item in arr{
            if let it = item as? [String : Any?]{
                addresses.append(Address.init(dict: it ))
            }
        }
    }
}

class AddAddressResponseModel : NSObject{
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["Status"] as? Int{
            statusCode = value
        }
    }
}

class RemoveAddressResponseModel : NSObject{
    var statusCode:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["Status"] as? Int{
            statusCode = value
        }
    }
}

class Address : NSObject{
    var addressId:Int = 0
    var customerId:Int = 0
    var customerLocationName:String = ""
    var deliveryAddress:String = ""
    var deliveryCity:String = ""
    var deliveryLandMark:String = ""
    var deliveryMapLocation:String = ""
    var deliveryNickName:String = ""
    var deliveryPhoneNumber:String = ""
    var deliveryState:String = ""
    var deliveryCoordinates:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["address_id"] as? String{
            if let addID = Int(value){
                addressId = addID
            }
        }
        if let value = dict["customer_id"] as? String{
            if let cusID = Int(value){
                customerId = cusID
            }
        }
        if let value = dict["customer_location_name"] as? String{
            customerLocationName = value
        }
        if let value = dict["delivary_address"] as? String{
            deliveryAddress = value
        }
        if let value = dict["delivary_city"] as? String{
            deliveryCity = value
        }
        if let value = dict["delivary_landmark"] as? String{
            deliveryLandMark = value
        }
        if let value = dict["delivary_map_location"] as? String{
            deliveryMapLocation = value
        }
        if let value = dict["delivary_nick_name"] as? String{
            deliveryNickName = value
        }
        if let value = dict["delivary_phone_number"] as? String{
            deliveryPhoneNumber = value
        }
        if let value = dict["delivary_state"] as? String{
            deliveryState = value
        }
        if let value = dict["delivery_coordinates"] as? String{
            deliveryCoordinates = value
        }
    }
}

class QootOrderHistoryResponseModel : NSObject{
    var orderArray = [Order]()
    init(history:NSArray) {
        if let _dict = history as? [[String:Any?]]{
            for item in _dict{
                orderArray.append(Order.init(dict: item))
            }
        }
    }
}

class Order : NSObject{
    var orderId:Int = 0
    var kitchenName:String = ""
    var Status:Int = 0
    var kitchenComment:String = ""
    var date:String = ""
    var location:String = ""
    var amount:Float = 0.0
    var kitchenLogo:String = ""
    var orderGroup:Int = 0
    var kitchenId:Int = 0
    var delivery:Float = 0.0
    var dishes = [Dishes]()
    
    init(dict:[String:Any?]) {
        if let value = dict["orderid"] as? String{
            if let orderID = Int(value){
                orderId = orderID
            }
        }
        if let value = dict["kitchenname"] as? String{
            kitchenName = value
        }
        if let value = dict["status"] as? String{
            if let status = Int(value){
                Status = status
            }
        }
        if let value = dict["KitchenComment"] as? String{
            kitchenComment = value
        }
        if let value = dict["date"] as? String{
            date = value
        }
        if let value = dict["location"] as? String{
            location = value
        }
        if let value = dict["amount"] as? Float{
            amount = value
        }
        if let value = dict["kitchenlogo"] as? String{
            kitchenLogo = value
        }
        
        if let value = dict["ordergroup"] as? String{
            if let ordGroup = Int(value){
                orderGroup = ordGroup
            }
        }
        if let value = dict["kitchenid"] as? String{
            if let kitId = Int(value){
                kitchenId = kitId
            }
        }
        if let value = dict["delivery"] as? String{
            if let deliv = Float(value){
                delivery = deliv
            }
        }
        
        if let value = dict["Dishes"] as? NSArray{
            for item in value{
                dishes.append(Dishes.init(dict: item as! [String : Any?]))
            }
        }
        
    }
}

