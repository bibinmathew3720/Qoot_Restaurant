//
//  MenuVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/4/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class MenuVC: BaseViewController {
    var isLoggedIn:Bool = false
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInButtonView: UIView!
    @IBOutlet weak var switchToKitchenButton: UIButton!
    @IBOutlet weak var loginButtonViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var languageSegment: UISegmentedControl!
    
    var titleArray = ["Offers".localiz(),"Support".localiz()]
    //var imageArray = [#imageLiteral(resourceName: "offers"),#imageLiteral(resourceName: "support")]
    var titleArrayAccount = ["MyOrders".localiz(),"MyWallet".localiz(),"Offers".localiz(),"Support".localiz(),"Settings".localiz(),"Logout".localiz()]
    //var imageArrayAccount =  [#imageLiteral(resourceName: "myOrders"),#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "offers"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "logout")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
        uiUpdations()
        localisation()
        // Do any additional setup after loading the view.
    }
    
    func initialisation(){
         menuTableView.register(UINib.init(nibName: "ManuTVC", bundle: nil), forCellReuseIdentifier: "menuTVC")
        if LanguageManger.shared.currentLanguage == .en {
            languageSegment.selectedSegmentIndex = 0
        }
        else{
           languageSegment.selectedSegmentIndex = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isLoggedIn =  UserDefaults.standard.bool(forKey: Constant.VariableNames.isLoogedIn)
        uiUpdations()
    }
    
    func uiUpdations(){
        if isLoggedIn{
            logInButtonView.isHidden = true
            loginButtonViewHeightConstraint.constant = 0
            profileViewHeightConstraint.constant = 150
            profileView.isHidden = false
        }
        else{
            logInButtonView.isHidden = false
            loginButtonViewHeightConstraint.constant = 40
            profileViewHeightConstraint.constant = 0
            profileView.isHidden = true
        }
        self.menuTableView.reloadData()
    }
    
    func localisation(){
        self.logInButton.setTitle("Login".localiz(), for: UIControlState.normal)
        self.switchToKitchenButton.setTitle("SwitchToKitchen".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if LanguageManger.shared.currentLanguage != .en {
                let selectedLanguage:Languages = .en
                UserDefaults.standard.set("en" , forKey: "language")
                LanguageManger.shared.setLanguage(language: selectedLanguage)
                reinitialiseRoot()
            }
        }
        else{
            if LanguageManger.shared.currentLanguage != .ar {
                let selectedLanguage:Languages = .ar
                UserDefaults.standard.set("ar" , forKey: "language")
                LanguageManger.shared.setLanguage(language: selectedLanguage)
                reinitialiseRoot()
            }
        }
    }
    
    func reinitialiseRoot(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.initWindow()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let dashBoardVC = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        let dashBoardNavCntlr = UINavigationController.init(rootViewController: dashBoardVC)
        self.present(dashBoardNavCntlr, animated: true, completion: nil)
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

extension MenuVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount :Int = 0
        if self.isLoggedIn {
            rowCount = titleArrayAccount.count
        }
        else{
            rowCount = titleArray.count
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTVC", for: indexPath) as!ManuTVC
        cell.tag = indexPath.row
        if self.isLoggedIn{
            //cell.menuIcon.image = self.imageArrayAccount[indexPath.row]
            cell.menuLabel.text = self.titleArrayAccount[indexPath.row]
        }
        else{
            //cell.menuIcon.image = self.imageArray[indexPath.row]
            cell.menuLabel.text = self.titleArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isLoggedIn{
            if indexPath.row == 0{
               setOrderListVC()
            }
            else if indexPath.row == 2 {
                setOffersVC()
            }
            else if (indexPath.row == 4){
                setSettingsVC()
            }
            else if (indexPath.row == 5){
                settingLogoutPopup()
            }
        }
        else{
            if indexPath.row == 0 {
                setOffersVC()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHieght = 60
        return CGFloat(rowHieght)
    }
    
    func setOffersVC(){
      
    }
    
    func setOrderListVC(){
       
    }
    
    func setSettingsVC(){









    }
    
    func settingLogoutPopup(){
        self.slideMenuController()?.closeLeft()
        let alertController = UIAlertController(title: "LOGOUT".localiz(), message: "AREYOUSURE".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES".localiz(), style: .default) { (action:UIAlertAction) in
            UserDefaults.standard.set(false, forKey: Constant.VariableNames.isLoogedIn)
            User.deleteUser()
            self.uiUpdations()
        }
        let noAction = UIAlertAction(title: "NO".localiz(), style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true) {
        }
    }
    
}



