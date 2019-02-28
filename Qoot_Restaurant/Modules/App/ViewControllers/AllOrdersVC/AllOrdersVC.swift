//
//  AllOrdersVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 2/28/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class AllOrdersVC: BaseViewController {

    override func initView() {
        super.initView()
        initialisation()
        localization()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localization(){
        self.title = "MyOrders".localiz()
    }
    
    //MARK: Button Action
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
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
