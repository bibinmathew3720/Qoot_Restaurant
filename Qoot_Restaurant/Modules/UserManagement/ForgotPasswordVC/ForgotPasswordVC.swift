//
//  ForgotPasswordVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 1/16/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController {
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var toolBar: UIToolbar!
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
        addingLeftBarButton()
        phoneNoTF.inputAccessoryView = toolBar
    }
    
    func localisation(){
       self.title = "RecoverAccount".localiz()
       phoneNoTF.placeholder = "MobNoPlaceholder".localiz()
       nextButton.setTitle("Next".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if isValidInputs(){
            self.view.endEditing(true)
            callingSendOTPApi()
        }
    }
    
    @IBAction func toolBarDoneButtonAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func taolBarCancelButtonAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
         if let mobString = phoneNoTF.text{
            if mobString.count < 6{
                message = "ENTERVALIDMOBILENO".localiz()
                valid = false
            }
        }
        if (!valid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return valid
    }
    
    //MARK: Send OTP Api
    
    func  callingSendOTPApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingSendOTPApi(with: getSendOTPRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? SendOTPResponseModel{
                if model.status ==  1 {
                    self.showForgotOTPVC()
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.statusMessage, parentController: self)
                }
            }
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func getSendOTPRequestBody()->String{
        var dataString:String = ""
        if let mobString = phoneNoTF.text{
            let phString:String = "Phone=\(mobString.urlEncode())"
            dataString = dataString + phString + "&"
        }
        return dataString
    }
    
    func showForgotOTPVC(){
        let forgotPasswordOTPVC = ForgotPasswordOTPVC.init(nibName: "ForgotPasswordOTPVC", bundle: nil)
        forgotPasswordOTPVC.mobileNumberString = phoneNoTF.text
        self.navigationController?.pushViewController(forgotPasswordOTPVC, animated: true)
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
