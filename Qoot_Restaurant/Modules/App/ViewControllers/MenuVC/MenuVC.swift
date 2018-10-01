//
//  MenuVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/4/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class MenuVC: BaseViewController {
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var languageSegment: UISegmentedControl!
    
    var titleArrayAccount = ["AllOrders".localiz(),"MyDishes".localiz(),"Menu".localiz(),"Wallet".localiz(),"MyProfile".localiz(),"Logout".localiz()]
    //var imageArrayAccount =  [#imageLiteral(resourceName: "myOrders"),#imageLiteral(resourceName: "myWallet"),#imageLiteral(resourceName: "offers"),#imageLiteral(resourceName: "support"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "logout")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisation()
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
        updateStatusLabel()
    }
    
    func localisation(){
        
    }
    
    func updateStatusLabel(){
        if self.statusSwitch.isOn{
            self.statusLabel.text = "Online".localiz()
        }
        else{
            self.statusLabel.text = "Offline".localiz()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        updateStatusLabel()
        settingStatusSwitchPopup(withSwitch: sender)
    }
    
    func settingStatusSwitchPopup(withSwitch:UISwitch){
        let alertController = UIAlertController(title: "AreYouSure".localiz(), message: "ChangeKitchenOpenStatus".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES".localiz(), style: .default) { (action:UIAlertAction) in
            self.callingUpdateOnlineStatusApi()
        }
        let noAction = UIAlertAction(title: "NO".localiz(), style: .default) { (action:UIAlertAction) in
            self.statusSwitch.isOn = !self.statusSwitch.isOn
            self.updateStatusLabel()
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true) {
        }
    }
    
    //MARK: Update Online Status Api
    
    func  callingUpdateOnlineStatusApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingUpdateOnlineStatusApi(with: getOnlineStatusRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? UpdateOnlineStatusResponseModel{
                self.updateStatusLabel()
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
    
    func getOnlineStatusRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            let kitchenIdString:String = "KitchenId=\(user.kitchenId)"
            dataString = dataString + kitchenIdString + "&"
        }
        var status = 0
        if statusSwitch.isOn{
            status = 1
        }
        let statusString:String = "Status=\(status)"
        dataString = dataString + statusString
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

extension MenuVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArrayAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTVC", for: indexPath) as!ManuTVC
        cell.tag = indexPath.row
        //cell.menuIcon.image = self.imageArrayAccount[indexPath.row]
        cell.menuLabel.text = self.titleArrayAccount[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        }
        let noAction = UIAlertAction(title: "NO".localiz(), style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true) {
        }
    }
    
}



