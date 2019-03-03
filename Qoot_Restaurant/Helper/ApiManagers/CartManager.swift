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
        let orderListRequestModel = CLNetworkModel.init(url: BASE_URL+KitchenOrderHistory_URL, requestMethod_: "POST")
        orderListRequestModel.requestBody = body
        return orderListRequestModel
    }
    
    func getOrderHistoryResponseModel(dict:NSArray) -> Any? {
        let orderHistoryResponseModel = QootOrderHistoryResponseModel.init(history:dict)
        return orderHistoryResponseModel
    }
    
    
    //MARK: Change Order Status Api
    
    func changeOrderStatusApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForOrderStatus(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getOrderStatusResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForOrderStatus(with body:String)->CLNetworkModel{
        let changeOrderRequestModel = CLNetworkModel.init(url: BASE_URL+ChangeOrderStatus_URL, requestMethod_: "POST")
        changeOrderRequestModel.requestBody = body
        return changeOrderRequestModel
    }
    
    func getOrderStatusResponseModel(dict:[String : Any?]) -> Any? {
        let orderHistoryResponseModel = ChangeOrderStatusResponseModel.init(dict: dict)
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
    var Status:Int = 0
    var Comment:String = ""
    var orderDate:String = ""
    var totalAmount:Float = 0.0
    var deliveryDate:String = ""
    var dishes = [Dishes]()
    
    init(dict:[String:Any?]) {
        if let value = dict["OrderId"] as? String{
            if let orderID = Int(value){
                orderId = orderID
            }
        }
        if let value = dict["OrderStatus"] as? String{
            if let status = Int(value){
                Status = status
            }
        }
        if let value = dict["Comment"] as? String{
            Comment = value
        }
        if let value = dict["OrderDate"] as? String{
            orderDate = value
        }
        if let value = dict["TotalAmount"] as? Float{
            totalAmount = value
        }
        if let value = dict["DeliveryDate"] as? String{
            deliveryDate = value
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
            
        }
    }
}

class ChangeOrderStatusResponseModel: NSObject{
    var status:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["Status"] as? String{
            status = value
        }
    }
}



