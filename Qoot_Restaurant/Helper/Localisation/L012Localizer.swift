//
//  L012Localizer.swift
//  CCLUB
//
//  Created by Albin Joseph on 3/7/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

class L012Localizer: NSObject {
    class func DoTheSwizzling() {
        
        // 1
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: Selector(("specialLocalizedStringForKey:value:table:")))
        
    }
}

extension Bundle {
    
    func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = L102Language.currentAppleLanguage()
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"), let _bundle = Bundle(path:_path){
            bundle = _bundle
        }else {
            if let _path = Bundle.main.path(forResource: "Base", ofType: "lproj"),let _bundle = Bundle(path:_path){
                bundle = _bundle
            }
        }
        return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    }
}

/// Exchange the implementation of two methods for the same Class

func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let _origMethod =  class_getInstanceMethod(cls, originalSelector) else {
        return
    }
    let origMethod: Method = _origMethod
    guard let _overrideMethod =  class_getInstanceMethod(cls, overrideSelector) else {
        return
    }
    let overrideMethod: Method = _overrideMethod
    
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        
    } else {
        
        method_exchangeImplementations(origMethod, overrideMethod);
        
    }
    
}
