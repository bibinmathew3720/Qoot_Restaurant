//
//  CLScheduleViewController.swift
//  Benchr
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit
import UserNotifications

class CLScheduleViewController: BaseViewController {
    
    @IBOutlet weak var cLTableView: UITableView!
    var selectedIndex:Int = 0
    var selectedTimeIndex:Int = -1
    var WeekSelectedIndex:Int = 0
    var cLTimeSlotsModel:CLTimeSlotsModel?
    var requestModel:CLBookSlotsRequestModel = CLBookSlotsRequestModel()
    var days:[String] = [String]()
    var selectedDate = ""
    
    var orderResponse:GetOrdersResponse?
    
    override func initView() {
        super.initView()
        initialisation()
        getOrders()
    }
    
    func initialisation(){
        self.title = "OrderCalendar".localiz()
        addingLeftBarButton()
        registerNib()
        //selectedDate = CLUtility.convertDateToString(fromDate: Date(), toFormat: dateFormat.yyyy_MM_dd)
    }
    
    func getOrders(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetOrdersApi(with: getOrdersRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? GetOrdersResponse{
                self.orderResponse = model
                self.cLTableView.reloadData()
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
    
    func getOrdersRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            let kitchenIdString:String = "KitchenId=\(user.kitchenId)"
            dataString = dataString + kitchenIdString + "&"
        }
        else{
            let kitchenIdString:String = "KitchenId=39"
            dataString = dataString + kitchenIdString + "&"
        }
        dataString = dataString + "Status=Past"
        return dataString
    }
    
    
    func registerNib() -> () {
        
        cLTableView.register(UINib.init(nibName: "CLCalanderTableViewCell", bundle: nil), forCellReuseIdentifier: "CLCalanderTableViewCell")
    }
    
    @IBAction func setSchedule(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension CLScheduleViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CLCalanderTableViewCell") as! CLCalanderTableViewCell
            cell.delegate = self
            if let orderResponse = self.orderResponse {
                cell.setOrderResponse(orderResponse: orderResponse)
            }
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = "hello"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hiosdosdusod ds")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.row == 0{
        return 300
       }else{
        return 50.0
        }
    }
}

extension CLScheduleViewController:CLCalanderTableViewCellDelegate{
    func getSelectedDate(_ dateString: String) {
        self.selectedDate = dateString
    }
}

