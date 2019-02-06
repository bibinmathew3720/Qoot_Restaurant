//
//  ResetPasswordVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 1/19/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class ResetPasswordVC: BaseViewController {
    var checkOTPResponse:CheckOTPResponseModel?
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var updatePasswordButton: UIButton!
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localisation(){
        self.title = "CHANGEPASSWORD".localiz()
        passwordTF.placeholder = "NewPassword".localiz()
        confirmPwdTF.placeholder = "ConfirmNewPassword".localiz()
        updatePasswordButton.setTitle("UpdatePassword".localiz(), for: UIControlState.normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func updatePasswordButtonAction(_ sender: UIButton) {
        if isValidChangePasswordRequest(){
            callingChangePasswordApi()
        }
    }
    
    func isValidChangePasswordRequest()->Bool{
        var isValid = true
        var message = ""
        if (passwordTF.text?.isEmpty)!{
            message = "PASSWORDATLEASTSIXDIGITS".localiz()
            isValid = false
        }
        else if ((passwordTF.text?.count)! < 6){
            message = "PASSWORDATLEASTSIXDIGITS".localiz()
            isValid = false
        }
        else if passwordTF.text != confirmPwdTF.text{
            message = "NEWPASSWORDDOESNTMATCHES".localiz()
            isValid = false
        }
        if (!isValid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return isValid
    }
    
    //MARK: Change Password Api
    
    func  callingChangePasswordApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingChangePasswordApiForForgot(with: getChangePwdRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let model = model as? ChangePasswordResponseModel{
                if model.statusCode == 1{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: "PasswordChanged".localiz(), parentController: self, completion: { (okSuccess) in
                        for controller in self.navigationController!.viewControllers as Array {
                            if controller.isKind(of: LoginViewController.self) {
                               self.navigationController!.popToViewController(controller, animated: true)
                                break
                            }
                        }
                    })
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
    
    func getChangePwdRequestBody()->String{
        var dataString:String = ""
        if let newPwd = self.passwordTF.text {
            let newPwdString:String = "NewPWD=\(newPwd.urlEncode())"
            dataString = dataString + newPwdString + "&"
        }
        if let otpResponse = checkOTPResponse{
            let userIdString:String = "CustomerId=\(otpResponse.customerId)"
            dataString = dataString + userIdString
        }
        return dataString
    }

}

extension ResetPasswordVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == passwordTF){
            confirmPwdTF.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
}
