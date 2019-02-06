//
//  ForgotPasswordOTPVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 1/19/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class ForgotPasswordOTPVC: BaseViewController {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var resendOtpButton: UIButton!
    @IBOutlet weak var verifyOtpButton: UIButton!
    @IBOutlet var toolBar: UIToolbar!
    
    var mobileNumberString:String?
    var checkOTPResponseModel:CheckOTPResponseModel?
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
        addingLeftBarButton()
        otpTextField.inputAccessoryView = toolBar
    }
    
    func localisation(){
        self.title = "VerifyDevice".localiz()
        if let mobileNumber = mobileNumberString {
            headingLabel.text = "WeHaveSentOtpTo".localiz() + " \(mobileNumber)"
        }
        otpTextField.placeholder = "EnterOTPHere".localiz()
        resendOtpButton.setTitle("RESENDOTP".localiz(), for: UIControlState.normal)
        verifyOtpButton.setTitle("VERIFYOTP".localiz(), for: UIControlState.normal)
    }
    
    //MARK: Button Actions
    @IBAction func toolBarDoneButtonAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func toolBarCancelButtonAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func resendOTPButtonActin(_ sender: UIButton) {
        callingSendOTPApi()
    }
    
    @IBAction func verifyOTPButtonAction(_ sender: UIButton) {
        if isValidInputs(){
            callingCheckOTPApi()
        }
    }
    
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
        if let otpString = otpTextField.text{
            if otpString.count == 0{
                message = "INVALIDOTP".localiz()
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
        let progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.label.text = "ResendingOTP".localiz()
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
        if let phoneString = self.mobileNumberString{
            let phString:String = "Phone=\(phoneString.urlEncode())"
            dataString = dataString + phString + "&"
        }
        return dataString
    }
    
    //MARK: Check OTP Api
    
    func  callingCheckOTPApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingCheckOTPApiForForgot(with: getCheckOTPRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? CheckOTPResponseModel{
                self.checkOTPResponseModel = model
                if model.status ==  0 {
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: "INVALIDOTP".localiz(), parentController: self)
                }
                else{
                    self.loadResetPasswordVC()
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
    
    func getCheckOTPRequestBody()->String{
        var dataString:String = ""
        if let phoneString = self.mobileNumberString{
            let phString:String = "Phone=\(phoneString.urlEncode())"
            dataString = dataString + phString + "&"
        }
        if let otp = self.otpTextField.text{
            let otpString:String = "Otp=\(otp.urlEncode())"
            dataString = dataString + otpString
        }
        return dataString
    }
    
    func loadResetPasswordVC(){
        let resetPwdVC = ResetPasswordVC.init(nibName: "ResetPasswordVC", bundle: nil)
        resetPwdVC.checkOTPResponse = self.checkOTPResponseModel
        self.navigationController?.pushViewController(resetPwdVC, animated: true)
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
