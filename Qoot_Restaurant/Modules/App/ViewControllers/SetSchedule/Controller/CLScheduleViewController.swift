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
    
    override func initView() {
        super.initView()
        initialisation()
    }
    
    func initialisation(){
        self.title = "OrderCalendar".localiz()
        addingLeftBarButton()
        registerNib()
        //selectedDate = CLUtility.convertDateToString(fromDate: Date(), toFormat: dateFormat.yyyy_MM_dd)
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
