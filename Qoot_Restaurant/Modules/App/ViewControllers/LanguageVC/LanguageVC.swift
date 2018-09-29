//
//  LanguageVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/15/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class LanguageVC: BaseViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func initView() {
        super.initView()
        initialisation()
    }
    
    func initialisation(){
        if LanguageManger.shared.currentLanguage == .en {
            segmentControl.selectedSegmentIndex = 0
        }
        else{
            segmentControl.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        if segmentControl.selectedSegmentIndex == 0 {
            if LanguageManger.shared.currentLanguage != .en {
                let selectedLanguage:Languages = .en
                UserDefaults.standard.set("en" , forKey: "language")
                LanguageManger.shared.setLanguage(language: selectedLanguage)
            }
        }
        else{
            if LanguageManger.shared.currentLanguage != .ar {
                let selectedLanguage:Languages = .ar
                UserDefaults.standard.set("ar" , forKey: "language")
                LanguageManger.shared.setLanguage(language: selectedLanguage)
            }
        }
        setWalkThroughView()
    }
    
    func setWalkThroughView(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let walkThroughVC = WalkThroughVC.init(nibName: "WalkThroughVC", bundle: nil)
        appDelegate.window?.rootViewController = walkThroughVC
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
