//
//  L102Language.swift
//  CCLUB
//
//  Created by Albin Joseph on 3/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit
// constants

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class L102Language: NSObject {
    /// get current Apple language
    
    class func currentAppleLanguage() -> String{
        
        let userdef = UserDefaults.standard
        guard let _languages = userdef.object(forKey: APPLE_LANGUAGE_KEY) as? Array<Any> else {
            return ""
        }
        let langArray = _languages
        guard let _current = langArray.first as? String else {
            return ""
        }
        let current = _current
        
        return current
        
    }
    /// set @lang to be the first in Applelanguages list
    
    class func setAppleLAnguageTo(lang: String) {
        
        let userdef = UserDefaults.standard
        
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        
        userdef.synchronize()
        
    }

}
