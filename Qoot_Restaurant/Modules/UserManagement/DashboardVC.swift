//
//  DashboardVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class DashboardVC: BaseViewController {
    @IBOutlet weak var loginViaFBButton: UIButton!
    @IBOutlet weak var loginViaGoogleButton: UIButton!
    @IBOutlet weak var loginViaQootButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    
    override func initView() {
        initialisation()
        localisation()
        addRegisterLabel()
        addingLeftBarButton()
    }
    
    func initialisation(){
        self.title = "Qoot".localiz()
    }
    
    func localisation(){
        loginViaFBButton.setTitle("LOGINVIAFACEBOOK".localiz(), for: UIControlState.normal)
        loginViaGoogleButton.setTitle("LOGINVIAGOOGLE".localiz(), for: UIControlState.normal)
        loginViaQootButton.setTitle("LOGINVIAQOOT".localiz(), for: UIControlState.normal)
    }
    
    func addRegisterLabel(){
        let string1 = "DONTHAVEANACCOUNT".localiz()
        let string2 = "REGISTER".localiz()
        let myString:String = string1 + " " + string2
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont(name: Constant.Font.Regular, size: 19)!])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: Constant.Colors.CommonRedColor, range: NSRange(location:myString.count - string2.count,length:string2.count))
        registerLabel.attributedText = myMutableString
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnGuestLabel(_:))))
    }
    
    //Tap Gesture Action
    
    @objc func handleTapOnGuestLabel(_ recognizer: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: Constant.SegueIdentifiers.dashBoardToRegister, sender: nil)
    }
    
    //Button Actions
    
    @IBAction func facebookButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func googlePlusButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func logInButtonAction(_ sender: UIButton) {
        let loginVC = LoginViewController.init(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
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
