//
//  OrderTVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 2/28/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit
protocol OrderTVCDelegate{
    func viewDetailButtonActionDelegateWithTag(tag:Int)
    func acceptOrderButtonActionDelegateWithTag(tag:Int)
    func rejectOrderButtonActionDelegateWithTag(tag:Int)
}
class OrderTVC: UITableViewCell {
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderStatusHeadingLabel: UILabel!
    @IBOutlet weak var orderStatusTF: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var viewDetailForNewOrder: UIButton!
    @IBOutlet weak var rejectOrderButton: UIButton!
    @IBOutlet weak var acceptOrderButton: UIButton!
    @IBOutlet weak var viewDetailButtonForOngoingOrders: UIButton!
    @IBOutlet weak var pstOrderView: UIView!
    @IBOutlet weak var newOrderView: UIView!
    @IBOutlet weak var ongoingOrderView: UIView!
    @IBOutlet weak var dishesTableViewHeiConstraint: NSLayoutConstraint!
    var delegate:OrderTVCDelegate?
    var dishes:[Dishes]?
    override func awakeFromNib() {
        super.awakeFromNib()
        localization()
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Constant.Colors.CommonGreyColor.cgColor
        dishesTableView.register(UINib(nibName: "ItemDetailTableCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        dishesTableView.dataSource = self
        dishesTableView.delegate = self
        // Initialization code
    }
    
    func localization(){
        viewDetailsButton.setTitle("ViewDetails".localiz(), for: .normal)
        viewDetailButtonForOngoingOrders.setTitle("ViewDetails".localiz(), for: .normal)
        viewDetailForNewOrder.setTitle("ViewDetails".localiz(), for: .normal)
        rejectOrderButton.setTitle("RejectOrder".localiz(), for: .normal)
        acceptOrderButton.setTitle("AcceptOrder".localiz(), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Button Actions
    
    @IBAction func viewDetailButtonAction(_ sender: UIButton) {
        if let del = delegate{
            del.viewDetailButtonActionDelegateWithTag(tag: self.tag)
        }
    }
    
    @IBAction func rejectOrderButtonAction(_ sender: UIButton) {
        if let del = delegate{
            del.rejectOrderButtonActionDelegateWithTag(tag: self.tag)
        }
    }
    
    @IBAction func acceptOrderButtonAction(_ sender: UIButton) {
        if let del = delegate{
            del.acceptOrderButtonActionDelegateWithTag(tag: self.tag)
        }
    }
    
    func setOrderDetails(orderDetail:Order){
        self.orderNumberLabel.text = "OrderNumber".localiz() + ":\(orderDetail.orderId)"
        self.totalPriceLabel.text  = "SAR".localiz() + ": \(orderDetail.totalAmount)"
        self.orderStatusHeadingLabel.text = "OrderStatus".localiz()
        self.dishes = orderDetail.dishes
        dishesTableViewHeiConstraint.constant = CGFloat(20 * orderDetail.dishes.count)
        dishesTableView.reloadData()
        switch orderDetail.Status {
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

extension OrderTVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dishs = self.dishes{
            return dishs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemDetailTableCell
        if let dishs = self.dishes{
            cell.setDishes(dish: dishs[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
