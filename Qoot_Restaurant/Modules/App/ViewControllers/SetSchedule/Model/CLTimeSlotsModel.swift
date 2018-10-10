//
//  CLTimeSlotsModel.swift
//  6thWand
//
//  Created by Albin Joseph on 12/08/18.
//  Copyright © 2018 Codelynks. All rights reserved.
//

import UIKit

class CLTimeSlotsModel: NSObject {
    var cLTimeSlotModel:[CLTimeSlotModel] = [CLTimeSlotModel]()
    init(array:[[String:Any?]]){
        for dict in array{
            cLTimeSlotModel.append(CLTimeSlotModel.init(dic: dict))
        }
    }
}

class CLTimeSlotModel: NSObject {
    var startTime:String = ""
    var endTime:String = ""
    var isAvaialable:Bool = true
    var cLBookingModel: CLBookingModel?
    init(dic:[String:Any?]){
        if let value = dic["start_time"] as? String{
            startTime = value
        }
        if let value = dic["end_time"] as? String{
            endTime = value
        }
        if let value = dic["is_available"] as? Int{
            isAvaialable = (value == 1) ? true : false
        }
        if let value = dic["bookings"] as? [String:Any?]{
           cLBookingModel = CLBookingModel.init(dict: value)
        }
    }
}

class CLBookingModel: NSObject {
    var active:String = ""
    var cancelled:String = ""
    init(dict:[String:Any?]){
        if let value = dict["active"] as? [String:Any?]{
            if let _value = value["count"] as? Int{
                active = String(_value)
            }
        }
        if let value = dict["canceled"] as? [String:Any?]{
            if let _value = value["count"] as? Int{
                cancelled = String(_value)
            }
        }
    }
}

class CLBookSlotsRequestModel: NSObject {
    var bookingDate:String = ""
    var bookingTime:String = ""
    var optionId:String = ""
    func getRequestBody() -> [String:Any] {
        var dict:[String:Any] = [String:Any]()
        dict.updateValue(bookingDate, forKey: "date")
        dict.updateValue(bookingTime, forKey: "time")
        dict.updateValue(optionId, forKey: "option")
        return dict
    }
}



