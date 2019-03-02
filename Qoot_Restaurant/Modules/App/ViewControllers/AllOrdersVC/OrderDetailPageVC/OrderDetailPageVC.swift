//
//  OrderDetailPageVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 3/2/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class OrderDetailPageVC: BaseViewController {
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateLabelForNeworders: UILabel!
    @IBOutlet weak var deleveryDateheadingLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var messageHeadingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dishesTableViewHeiConstraint: NSLayoutConstraint!
    
    var orderType:OrderType?
    var orderDetails:Order?
    override func initView() {
        super.initView()
        initialisation()
        localization()
        populateData()
    }
    
    func initialisation(){
        addingLeftBarButton()
        cardView.layer.borderColor = Constant.Colors.CommonBlackColor.cgColor
        cardView.layer.borderWidth = 0.5
        dishesTableView.register(UINib(nibName: "ItemDetailTableCell", bundle: nil), forCellReuseIdentifier: "itemCell")
         dishesTableView.register(UINib(nibName: "ItemDetailHeadingTVC", bundle: nil), forCellReuseIdentifier: "itemDetailHeadingCell")
    }
    
    func localization(){
        if let ordType = orderType{
            if ordType == .newOrders{
                self.title = "NewOrders".localiz()
            }
            else if ordType == .ongoingOrder{
                self.title = "OngoingOrders".localiz()
            }
            else if ordType == .pastOrder{
                self.title = "PastOrders".localiz()
            }
        }
    }
    
    func populateData(){
        if let ordDetails = orderDetails{
            self.orderNumberLabel.text = "OrderNumber".localiz() + ":\(ordDetails.orderId)"
            self.priceLabel.text  = "SAR".localiz() + ": \(ordDetails.totalAmount)"
            if let ordType = orderType{
                if ordType == .newOrders{
                    dateLabel.text = "OrderDate".localiz()+":"
                    dateLabelForNeworders.text = ordDetails.orderDate
                    deleveryDateheadingLabel.text = "DeliveryDate".localiz()+":"
                    deliveryDateLabel.text = ordDetails.deliveryDate
                }
                else if ordType == .ongoingOrder{
                    
                }
                else if ordType == .pastOrder{
                    self.dateLabel.text = ordDetails.deliveryDate
                    self.subTotalLabel.text = "".localiz()
                }
            }
            self.messageHeadingLabel.text = "Message".localiz()
            if (ordDetails.Comment.count>0){
                self.messageLabel.text = ordDetails.Comment
            }
            else{
                self.messageLabel.text = "NoMessageFromCustomer".localiz()
            }
            dishesTableViewHeiConstraint.constant = CGFloat((20 * ordDetails.dishes.count ) + 40)
            if let user = User.getUser(){
                self.deliveryLabel.text = "DeliveryFee".localiz() + " : " + "\(user.deliveryFee)"
                let subTotal = ordDetails.totalAmount - user.deliveryFee
                self.subTotalLabel.text = "SubTotal".localiz() + " : " + "\(subTotal)"
            }
           
            switch ordDetails.Status {
                //        case 0:
                //            rejectedTitle.text = "OrderPlaced".localiz()
            //            settingOrderPlacedLayer()
            case 1:
                statusLabel.text = "RejectedByTheKitchen".localiz()
                //        case 2:
                //            rejectedTitle.text = "Preparing".localiz()
            //            settingPreparingLayer()
            case 3:
                statusLabel.text = "CancelledByTheUser".localiz()
                //        case 4:
                //            rejectedTitle.text = "OnTheWay".localiz()
            //            settingOnTheWayLayer()
            case 5:
                statusLabel.text = "Delivered".localiz()
            case 6:
                statusLabel.text = "AutoRejected".localiz()
            default:
                statusLabel.text = "".localiz()
            }
        }
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

extension OrderDetailPageVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let ordDetails = orderDetails{
            return ordDetails.dishes.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemDetailHeadingCell", for: indexPath) as! ItemDetailHeadingTVC
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemDetailTableCell
            if let ordDetails = orderDetails{
                cell.setDishes(dish: ordDetails.dishes[indexPath.row - 1])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 40
        }
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
