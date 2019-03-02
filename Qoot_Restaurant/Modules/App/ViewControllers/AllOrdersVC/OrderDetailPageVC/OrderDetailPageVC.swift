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
    @IBOutlet weak var messageHeadingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
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
        //orderListTV.register(UINib.init(nibName: "OrderTVC", bundle: nil), forCellReuseIdentifier: "orderCell")
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
                    
                }
                else if ordType == .ongoingOrder{
                    
                }
                else if ordType == .pastOrder{
                    self.dateLabel.text = ordDetails.deliveryDate
                }
            }
            self.messageHeadingLabel.text = "Message".localiz()
            if (ordDetails.Comment.count>0){
                self.messageLabel.text = ordDetails.Comment
            }
            else{
                self.messageLabel.text = "NoMessageFromCustomer".localiz()
            }
            //self.dishes = orderDetail.dishes
           // dishesTableViewHeiConstraint.constant = CGFloat(20 * orderDetail.dishes.count)
            dishesTableView.reloadData()
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
