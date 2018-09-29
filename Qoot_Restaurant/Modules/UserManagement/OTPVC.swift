//
//  OTPVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/17/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class OTPVC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var otpTF: UITextField!
    @IBOutlet weak var smsTitleLabel: UILabel!
    @IBOutlet weak var resendOTPButton: UIButton!
    @IBOutlet weak var verifyOTPButton: UIButton!
    var mobNoString:String?
    override func initView() {
        super.initView()
        initialisation()
    }
    
    func initialisation(){
        self.title = Constant.AppName
        self.navigationController?.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        otpTF.becomeFirstResponder()
        localisation()
    }
    
    func localisation(){
        if let mobNo = mobNoString{
            headingLabel.text = "CONFIRMCODEMGE".localiz() + " \(mobNo)\n" + "ENTERCODEBELOW".localiz()
        }
        smsTitleLabel.text = "DIDNTRECEIVESMS".localiz()
        resendOTPButton.setTitle("RESENDOTP".localiz(), for: UIControlState.normal)
        verifyOTPButton.setTitle("VERIFYOTP".localiz(), for: UIControlState.normal)
    }

    @IBAction func resendOTPButtonAction(_ sender: UIButton) {
        callingSendOTPApi()
    }
    @IBAction func verifyOTPButtonAction(_ sender: UIButton) {
        if isValidInputs(){
            callingCheckOTPApi()
        }
    }
    
    @IBAction func tapgestureAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
        if (otpTF.text?.isEmpty)!{
            message = "INVALIDOTP".localiz()
            valid = false
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
//                if model.statusMessage.count > 0 {
//                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.statusMessage, parentController: self)
//                }
//                else{
//                    self.dismiss(animated: true, completion: nil)
//                }
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
        if let phoneString = self.mobNoString{
            let phString:String = "Phone=\(phoneString.urlEncode())"
            dataString = dataString + phString + "&"
        }
        return dataString
    }
    
    //MARK: Check OTP Api
    
    func  callingCheckOTPApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingCheckOTPApi(with: getCheckOTPRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? CheckOTPResponseModel{
                //                if model.statusMessage.count > 0 {
                //                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.statusMessage, parentController: self)
                //                }
                //                else{
                //                    self.dismiss(animated: true, completion: nil)
                //                }
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
    
    func getCheckOTPRequestBody()->String{
        var dataString:String = ""
        if let phoneString = self.mobNoString{
            let phString:String = "Phone=\(phoneString.urlEncode())"
            dataString = dataString + phString + "&"
        }
        if let otp = self.otpTF.text{
            let otpString:String = "Otp=\(otp.urlEncode())"
            dataString = dataString + otpString
        }
        return dataString
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
