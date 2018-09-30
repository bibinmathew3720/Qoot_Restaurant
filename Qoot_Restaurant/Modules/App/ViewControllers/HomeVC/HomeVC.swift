//
//  HomeVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 9/30/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    override func initView() {
        super.initView()
        initialisation()
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
        addingLeftBarButton()
        self.leftButton?.setImage(UIImage(named: "hamburger"), for: UIControlState.normal)
       
        //setUpCollectionView()
    }
    
    override func leftNavButtonAction() {
        if LanguageManger.shared.currentLanguage == .en {
            self.slideMenuController()?.openLeft()
        }
        else{
            self.slideMenuController()?.openRight()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
