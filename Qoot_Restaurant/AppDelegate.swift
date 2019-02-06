//
//  AppDelegate.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 9/27/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setNavigationBarProperties()
        localisationMethod()
        initWindow()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        GMSPlacesClient.provideAPIKey(Constant.ApiKeys.googleMapKey)
        GMSServices.provideAPIKey(Constant.ApiKeys.googleMapKey)
        return true
    }
    
    func initWindow(){
        let secondLogin = UserDefaults.standard.bool(forKey: Constant.VariableNames.isSecondLogIn)
        if secondLogin{
            if let user = User.getUser(){
                let homeVC = HomeVC.init(nibName: "HomeVC", bundle: nil)
                let homeNavVC = UINavigationController.init(rootViewController: homeVC)
                let menuVC = MenuVC.init(nibName: "MenuVC", bundle: nil)
                var slideMenuController:ExSlideMenuController?
                if LanguageManger.shared.currentLanguage == .en {
                    slideMenuController = ExSlideMenuController(mainViewController: homeNavVC, leftMenuViewController: menuVC)
                }
                else{
                    slideMenuController = ExSlideMenuController(mainViewController: homeNavVC, rightMenuViewController: menuVC)
                }
                self.window?.rootViewController = slideMenuController
            }
            else{
                let storyBaord = UIStoryboard(name: "Main", bundle: nil)
                let dashboardVC = storyBaord.instantiateViewController(withIdentifier: "DashboardVC")
                let dashBoardNavCntr = UINavigationController.init(rootViewController: dashboardVC)
                self.window?.rootViewController = dashBoardNavCntr
            }
        }
        else{
            let languageVC = LanguageVC.init(nibName: "LanguageVC", bundle: nil)
            self.window?.rootViewController = languageVC
        }
    }
    
    func localisationMethod(){
        //Mark: Localisation handle
        var selectedLanguage:Languages?
        let language = UserDefaults.standard.value(forKey: "language")
        if let _language = language as? String{
            
            selectedLanguage = (_language == "en") ? .en : .ar
        }else{
            selectedLanguage =  .en
        }
        LanguageManger.shared.setLanguage(language: selectedLanguage!)
    }
    
    func setNavigationBarProperties(){
        UINavigationBar.appearance().barTintColor = Constant.Colors.CommonMeroonColor
        UINavigationBar.appearance().tintColor = Constant.Colors.CommonMeroonColor
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: Constant.Font.Bold, size: 20)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension Notification.Name {
    static let postNotification = Notification.Name("LoginNotification")
    static let menuResetNotification = Notification.Name("ResetMenuNotification")
}

