//
//  RegisterVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class RegisterVC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneNoTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func initView() {
        initialisation()
        localisation()
    }
    
    func initialisation(){
        self.title = "RegisterTitle".localiz()
        addingLeftBarButton()
    }
    
    func localisation(){
       nameTF.placeholder = "NamePlaceholder".localiz()
       emailTF.placeholder = "EmailPlaceholder".localiz()
       phoneNoTF.placeholder = "MobNoPlaceholder".localiz()
       pwdTF.placeholder = "PwdPlaceholder".localiz()
       confirmPwdTF.placeholder = "ConfirmPwdPlaceholder".localiz()
       maleLabel.text = "Male".localiz()
       femaleLabel.text = "Female".localiz()
       submitButton.setTitle("SIGNUP".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func maleButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        femaleButton.isSelected = false
    }
    
    @IBAction func femaleButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        maleButton.isSelected = false
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if isValidInputs(){
           callingSignUpApi()
        }
    }
    
    //MARK: Validation
    
    func isValidInputs()->Bool{
        var valid = true
        var message = ""
        if (nameTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (emailTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (phoneNoTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (pwdTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (confirmPwdTF.text?.isEmpty)!{
            message = "FILLMANDATORYFIELDS".localiz()
            valid = false
        }
        else if (pwdTF.text != confirmPwdTF.text){
            message = "PASSWORDSDOESNOTMATCHES".localiz()
            valid = false
        }
        else if ((pwdTF.text?.count)!<8){
            message = "INVALIDPASSWORDCHARACTERS".localiz()
            valid = false
        }
        else if !(emailTF.text?.isValidEmail())!{
            message = "INVALIDEMAIL".localiz()
            valid = false
        }
        if (!valid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return valid
    }
    
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTF {
            emailTF.becomeFirstResponder()
        }
        else if textField == self.emailTF {
            phoneNoTF.becomeFirstResponder()
        }
        else if textField == self.phoneNoTF {
            pwdTF.becomeFirstResponder()
        }
        else if textField == self.pwdTF {
            confirmPwdTF.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
       return true
    }
    
    //MARK: Sign Up Api
    
    func  callingSignUpApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingSignUpApi(with: getRegisterRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.performSegue(withIdentifier: Constant.SegueIdentifiers.registerToOTP, sender: self)
            if let model = model as? QootRegisterResponseModel{
                if model.statusCode == 1{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.errorMessage, parentController: self)
                }
                else{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: model.statusMessage, parentController: self, completion: { (okSuccess) in
                            self.navigationController?.popViewController(animated: true)
                    })
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
    
    func getRegisterRequestBody()->String{
        var dataString:String = ""
        if let name = self.nameTF.text {
            let nameString:String = "Name=\(name.urlEncode())"
            dataString = dataString + nameString + "&"
        }
        if let email = self.emailTF.text {
            let emailString:String = "Email=\(email.urlEncode())"
            dataString = dataString + emailString + "&"
        }
        
        if let phone = self.phoneNoTF.text {
            let phoneString:String = "Phone=\(phone.urlEncode())"
            dataString = dataString + phoneString + "&"
        }
        
        if let password = self.pwdTF.text {
            let passwordString:String = "Password=\(password.urlEncode())"
            dataString = dataString + passwordString + "&"
        }
        if maleButton.isSelected {
            dataString = dataString + "RegType=1&"
        }
        else{
            dataString = dataString + "RegType=2&"
        }
        dataString = dataString + "RegId=1"
        return dataString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.SegueIdentifiers.registerToOTP{
            let otpVC = segue.destination as! OTPVC
            otpVC.mobNoString = self.phoneNoTF.text
        }
    }
   
}
