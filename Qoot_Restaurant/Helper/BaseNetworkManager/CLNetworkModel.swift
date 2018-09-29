//
//  CLNetworkModel.swift
//  CCLUB
//
//  Created by Albin Joseph on 2/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

enum ErrorType : Int {
    case noNetwork = 1
    case dataError
    case notFound
    case internalServerError
}

class CLNetworkModel: NSObject {
    var requestURL: String?
    var requestMethod: String?
    var requestBody: String?
    var requestHeader: [String : String]?
    
    init(url : String, requestMethod_ : String){
        requestURL = url
        requestMethod = requestMethod_
        //let user = User.getUser()
        requestHeader = [String : String]()
        _ = requestHeader?.updateValue("application/x-www-form-urlencoded", forKey: "Content-Type")
//        _ = requestHeader?.updateValue("cW9vdC5vbmxpbmVhcGl0b2tlbmJ5amlqbw==", forKey: "apikey")
//        if LanguageManger.shared.currentLanguage != .ar {
//            _ = requestHeader?.updateValue("en", forKey: "lang")
//        }
//        else{
//            _ = requestHeader?.updateValue("ar", forKey: "lang")
//        }
        
//        if let _sessionToken = user?.sessionToken{
//            _ = requestHeader?.updateValue(_sessionToken, forKey: "Session-Token")
//        }
    }
}
