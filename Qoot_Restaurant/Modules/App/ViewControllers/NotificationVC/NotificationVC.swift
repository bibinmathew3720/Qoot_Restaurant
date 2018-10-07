//
//  NotificationVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/7/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class NotificationVC: BaseViewController {

    @IBOutlet weak var notificationTableView: UITableView!
    var notificationResponse:NotifiationsResponseModel?
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        getNotificationsApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
        notificationTableView.register(UINib.init(nibName: "NotificationsTVC", bundle: nil), forCellReuseIdentifier: "notificationCell")
        notificationTableView.estimatedRowHeight = 100
        notificationTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func localisation(){
        self.title = "Notifications".localiz()
    }
    
    func getNotificationsApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetNotificationsApi(with: getNotificationsRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? NotifiationsResponseModel{
                self.notificationResponse = model
                self.notificationTableView.reloadData()
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
    
    func getNotificationsRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            let kitchenIdString:String = "UserId=\(user.kitchenId)"
            dataString = dataString + kitchenIdString
        }
        else{
            let kitchenIdString:String = "UserId=39"
            dataString = dataString + kitchenIdString
        }
        return dataString
    }
    
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

extension NotificationVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notResponse = self.notificationResponse{
            return notResponse.notifications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as!NotificationsTVC
        if let notResponse = self.notificationResponse{
            cell.setNotificationDetails(notification:notResponse.notifications[indexPath.row])
        }
        
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }
}
