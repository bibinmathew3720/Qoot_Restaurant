//
//  OrderDetailPageVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 3/2/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit
import GrowingTextView

protocol OrderDetailDelegate {
    func orderCompletedDelegate()
}

class OrderDetailPageVC: BaseViewController {
    @IBOutlet weak var commmentView: UIView!
    @IBOutlet weak var commentHeadingLabel: UILabel!
    @IBOutlet weak var commentTV: GrowingTextView!
    @IBOutlet weak var rejectButtonOfComment: UIButton!
    
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
    
    @IBOutlet weak var ongoingOrderView: UIView!
    @IBOutlet weak var orderStatusHeadingLabel: UILabel!
    @IBOutlet weak var orderStatusTF: UITextField!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptButtton: UIButton!
    @IBOutlet weak var newOrderView: UIView!
    @IBOutlet weak var pastOrdersView: UIView!
    
    @IBOutlet weak var dishesTableViewHeiConstraint: NSLayoutConstraint!
    var delegate:OrderDetailDelegate?
    
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
                self.newOrderView.isHidden = false
            }
            else if ordType == .ongoingOrder{
                self.title = "OngoingOrders".localiz()
                self.ongoingOrderView.isHidden = false
            }
            else if ordType == .pastOrder{
                self.title = "PastOrders".localiz()
                self.pastOrdersView.isHidden = false
            }
        }
        self.rejectButton.setTitle("RejectOrder".localiz(), for: .normal)
        self.acceptButtton.setTitle("AcceptOrder".localiz(), for: .normal)
        self.orderStatusHeadingLabel.text = "OrderStatus".localiz()
        
        commentHeadingLabel.text = "Comment".localiz()
        commentTV.placeholder = "EnterTheRejectionReasonHere".localiz() + " (" + "IfAny".localiz() + ")"
        rejectButtonOfComment.setTitle("RejectOrder".localiz(), for: .normal)
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
                    dateLabel.text = "OrderDate".localiz()+":"
                    dateLabelForNeworders.text = ordDetails.orderDate
                    deleveryDateheadingLabel.text = "DeliveryDate".localiz()+":"
                    deliveryDateLabel.text = ordDetails.deliveryDate
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
            case 2:
                orderStatusTF.text = "Preparing".localiz()
                statusLabel.text = "Preparing".localiz()
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
    
    //MARK: Button Actions
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.commmentView.isHidden = true;
    }
    
    @IBAction func rejectButtonAction(_ sender: UIButton) {
        self.commmentView.isHidden = false
    }
    
    @IBAction func acceptButtonAction(_ sender: UIButton) {
        if let order = orderDetails{
            callingChangeOrderStatusApi(orderStatus: .accept, order: order)
        }
    }
    
    @IBAction func rejectButtonActionForComment(_ sender: UIButton) {
        if let order = orderDetails{
            callingChangeOrderStatusApi(orderStatus: .reject, order: order)
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
    
    func callingChangeOrderStatusApi(orderStatus:OrderStatus,order:Order){
        let progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.label.text = "Loading".localiz()
        CartManager().changeOrderStatusApi(with: getChangeStatusRequestBody(orderStatus: orderStatus,order: order), success: { (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ChangeOrderStatusResponseModel{
                if (model.status == "true"){
                    if let dele = self.delegate{
                        dele.orderCompletedDelegate()
                    }
                    if (orderStatus == .reject){
                        self.commmentView.isHidden = true
                    }
                    self.navigationController?.popViewController(animated: true)
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
        }
    }
    
    func getChangeStatusRequestBody(orderStatus:OrderStatus,order:Order)->String{
        var dataString:String = ""
        let orderIdString:String = "OrderId=\(order.orderId)"
        dataString = dataString + orderIdString + "&"
        var ordStatus = 0
        var commentString:String = "Comment="
        if(orderStatus == .accept){
            ordStatus = 2
        }
        else if(orderStatus == .reject){
            ordStatus = 3
            if let comm = self.commentTV.text{
                commentString = commentString + comm
            }
        }
        let orderStatus:String = "Status=\(ordStatus)"
        dataString = dataString + orderStatus + "&"
        
        dataString = dataString + commentString
        return dataString
    }

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
