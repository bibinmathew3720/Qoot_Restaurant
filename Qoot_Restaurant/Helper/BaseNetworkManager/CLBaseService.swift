//
//  CLBaseService.swift
//  CCLUB
//
//  Created by Albin Joseph on 2/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

class CLBaseService: NSObject {
    func didReceiveStatesResponseSuccessFully(_ responseData:Data?)->(responseJson : [String : Any?]? , error_:Any?){
        
        let jsonError : NSError = NSError(domain: "FAILED", code: 0, userInfo: nil)
        
        if let results = responseData{
            
            do{
                if let responseObj = try JSONSerialization.jsonObject(with: results, options: .allowFragments) as? [String : Any]{
                    if JSONSerialization.isValidJSONObject(responseObj){
                        return (responseObj,nil)
                    }
                    else{
                        return (nil , jsonError)
                    }
                }
                else{
                    return (nil , jsonError)
                }
            }
            catch let error as NSError{
                print(error)
                return (nil , error)
            }
        }else{
            print(jsonError)
            return (nil , jsonError)
        }
    }
    func didReceiveArrayResponseSuccessFully(_ responseData:Data?)->(responseJson : NSArray? , error_:Any?){
        let jsonError : NSError = NSError(domain: "FAILED", code: 0, userInfo: nil)
        let responseArray = [String]()
        if let results = responseData{
            
            do{
                
                if let responseObj = try JSONSerialization.jsonObject(with: results, options: .allowFragments) as? NSArray{
                    if JSONSerialization.isValidJSONObject(responseObj){
                        return (responseObj,nil)
                    }
                    else{
                        return (responseArray as NSArray , jsonError)
                    }
                }
                else{
                    return (responseArray as NSArray , jsonError)
                }
            }
            catch let error as NSError{
                print(error)
                return (responseArray as NSArray , error)
            }
        }else{
            print(jsonError)
            return (responseArray as NSArray , jsonError)
        }
    }
}
