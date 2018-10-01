//
//  HomeVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 9/30/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    var dashBoardResponse:DashboardResponseModel?
    let homeDataArray = ["TotalVisitors".localiz(),"VisitorsOnline".localiz(),"EarnedToday".localiz(),"QootBalance".localiz(),"TodaysMenu".localiz(),"TodaysOrder".localiz(),"OrderCalendar".localiz(),"AddNewDish".localiz()]
    let homeImagesArray = ["totalVisitors","totalVisitors","earnedToday","qootBalance","todaysMenu","todaysOrder","orderCalendar","addNewDish"]
    override func initView() {
        super.initView()
        initialisation()
        localization()
        callingDashboardApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
        self.leftButton?.setImage(UIImage(named: "hamburger"), for: UIControlState.normal)
        setUpCollectionView()
        addCartIconOnly()
        updateStatusLabel()
    }
    
    func localization(){
      self.title = "KitchenHome".localiz()
    }
    
    func setUpCollectionView(){
        homeCollectionView.register(UINib(nibName: "HomeCVC", bundle: nil), forCellWithReuseIdentifier:"homeCell" )
    }
    
    override func leftNavButtonAction() {
        if LanguageManger.shared.currentLanguage == .en {
            self.slideMenuController()?.openLeft()
        }
        else{
            self.slideMenuController()?.openRight()
        }
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
    
    func updateStatusLabel(){
        if self.statusSwitch.isOn{
            self.statusLabel.text = "Online".localiz()
        }
        else{
            self.statusLabel.text = "Offline".localiz()
        }
    }
    
    //MARK: Dashboard Api
    
    func  callingDashboardApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingDashboardApi(with: getDashBoardRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? DashboardResponseModel{
               self.dashBoardResponse = model
               self.homeCollectionView.reloadData()
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
    
    func getDashBoardRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            let kitchenIdString:String = "KitchenId=\(user.kitchenId)"
            dataString = dataString + kitchenIdString
        }
        return dataString
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

extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK- Collection View Datasources
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return homeDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCVC
        cell.subHeadingLabel.text = homeDataArray[indexPath.row]
        cell.iconImageView.image = UIImage.init(named: homeImagesArray[indexPath.row])
        cell.tag = indexPath.row
        if let dashBoardRsponse = self.dashBoardResponse{
            cell.setDashBoardDetails(dashBoardDetails:dashBoardRsponse)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (collectionView.frame.size.width - 10)/2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: Collection Cell Delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
