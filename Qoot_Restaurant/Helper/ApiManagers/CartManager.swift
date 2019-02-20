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
}



