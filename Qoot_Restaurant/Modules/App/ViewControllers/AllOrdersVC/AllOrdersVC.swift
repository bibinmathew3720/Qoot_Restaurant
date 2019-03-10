//
//  AllOrdersVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 2/28/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit
import GrowingTextView

enum OrderType{
    case ongoingOrder
    case pastOrder
    case newOrders
}

enum OrderStatus{
    case accept
    case reject
}

class AllOrdersVC: BaseViewController {
    @IBOutlet weak var orderHeadingCV: UICollectionView!
    @IBOutlet weak var orderListTV: UITableView!
    @IBOutlet weak var nothingToShowLabel: UILabel!
    
    //Comment View
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentHeadingLabel: UILabel!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var commentTextView: GrowingTextView!
    var selectedIndex = 0
    
    var orderHistoryResponse:QootOrderHistoryResponseModel?
    var orderType = OrderType.newOrders
    
    var ongoingOrderArray = [Order]()
    var pastOrderArray = [Order]()
    var newOrdersArray = [Order]()
    
    var ordersHeadingArray = ["NewOrders".localiz(),"OngoingOrders".localiz(),"PastOrders".localiz()]
    override func initView() {
        super.initView()
        initialisation()
        localization()
        setUpCollectionView()
        callingAllOrdersApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
        addHomeIconAndFilterIcon()
        orderListTV.register(UINib.init(nibName: "OrderTVC", bundle: nil), forCellReuseIdentifier: "orderCell")
    }
    
    func localization(){
        self.title = "MyOrders".localiz()
        self.nothingToShowLabel.text = "NothingToShow".localiz()
        
        commentHeadingLabel.text = "Comment".localiz()
        commentTextView.placeholder = "EnterTheRejectionReasonHere".localiz() + " (" + "IfAny".localiz() + ")"
        rejectButton.setTitle("RejectOrder".localiz(), for: .normal)
    }
    
    func setUpCollectionView(){
        orderHeadingCV.register(UINib(nibName: "OrdersHeadingCVC", bundle: nil), forCellWithReuseIdentifier:"orderHeadingCell" )
    }
    
    func callingAllOrdersApi(){
        let progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.label.text = "FetchingOrders".localiz()
        CartManager().callingGetOrderListApi(with: getAllOrdersRequestBody(), success: { (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootOrderHistoryResponseModel{
                self.orderHistoryResponse = model
                self.populateOrderList()
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
    
    func getAllOrdersRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            let kitchenIdString:String = "KitchenId=\(user.kitchenId)"
            dataString = dataString + kitchenIdString + "&"
        }
        let statusString:String = "Status=All"
        dataString = dataString + statusString
        return dataString
    }
    
    func populateOrderList(){
        if let orderHistory = self.orderHistoryResponse{
            self.newOrdersArray = orderHistory.orderArray.filter({($0.Status == 0)})
            self.ongoingOrderArray = orderHistory.orderArray.filter({($0.Status == 2 || $0.Status == 4)})
            self.pastOrderArray = orderHistory.orderArray.filter({($0.Status == 1 || $0.Status == 3 || $0.Status == 5 || $0.Status == 6)})
            orderHeadingCV.reloadData()
            self.orderListTV.reloadData()
            if(self.newOrdersArray.count == 0){
                self.nothingToShowLabel.isHidden = false
            }
        }
    }
    
    //MARK: Button Action
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.commentView.isHidden = true
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rejectButtonAction(_ sender: UIButton) {
        let order = self.newOrdersArray[selectedIndex]
        callingChangeOrderStatusApi(orderStatus: .reject, order: order)
    }
    override func homeButtonAction() {
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

extension AllOrdersVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK- Collection View Datasources
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ordersHeadingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OrdersHeadingCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "orderHeadingCell", for: indexPath) as! OrdersHeadingCVC
        cell.headingLabel.text = ordersHeadingArray[indexPath.row]
        if (indexPath.row == 0){
            if (self.orderType == .newOrders){
                cell.bottomView.isHidden = false
            }
            else{
                 cell.bottomView.isHidden = true
            }
            cell.countLabel.text = "\(newOrdersArray.count)"
        }
        else if (indexPath.row == 1){
            if (self.orderType == .ongoingOrder){
                cell.bottomView.isHidden = false
            }
            else{
                cell.bottomView.isHidden = true
            }
            cell.countLabel.text = "\(ongoingOrderArray.count)"
        }
        else if indexPath.row == 2{
            if (self.orderType == .pastOrder){
                cell.bottomView.isHidden = false
            }
            else{
                cell.bottomView.isHidden = true
            }
            cell.countLabel.text = "\(pastOrderArray.count)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 150, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: Collection Cell Delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.orderHeadingCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if indexPath.row == 0 {
            self.orderType = OrderType.newOrders
            if(self.newOrdersArray.count == 0){
                self.nothingToShowLabel.isHidden = false
            }
            else{
                self.nothingToShowLabel.isHidden = true
            }
        }
        else if indexPath.row == 1{
            self.orderType = OrderType.ongoingOrder
            if(self.ongoingOrderArray.count == 0){
                self.nothingToShowLabel.isHidden = false
            }
            else{
                self.nothingToShowLabel.isHidden = true
            }
        }
        else if indexPath.row == 2{
            self.orderType = OrderType.pastOrder
            if(self.pastOrderArray.count == 0){
                self.nothingToShowLabel.isHidden = false
            }
            else{
                self.nothingToShowLabel.isHidden = true
            }
        }
        orderHeadingCV.reloadData()
        orderListTV.reloadData()
    }
}

extension AllOrdersVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.orderType == .newOrders){
            return newOrdersArray.count
        }
        else if self.orderType == .ongoingOrder{
            return ongoingOrderArray.count
        }
        else if self.orderType == .pastOrder{
            return pastOrderArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as!OrderTVC
        if (self.orderType == .newOrders){
            cell.setOrderDetails(orderDetail: newOrdersArray[indexPath.section])
            cell.newOrderView.isHidden = false
            cell.pstOrderView.isHidden = true
            cell.ongoingOrderView.isHidden = true
        }
        else if(self.orderType == .ongoingOrder){
            cell.setOrderDetails(orderDetail: ongoingOrderArray[indexPath.section])
            cell.newOrderView.isHidden = true
            cell.pstOrderView.isHidden = true
            cell.ongoingOrderView.isHidden = false
        }
        else if(self.orderType == .pastOrder){
            cell.setOrderDetails(orderDetail: pastOrderArray[indexPath.section])
            cell.newOrderView.isHidden = true
            cell.pstOrderView.isHidden = false
            cell.ongoingOrderView.isHidden = true
        }
        cell.tag = indexPath.section
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        var tableViewheight = 0
        let itemTableViewCellHeight = 20
        if (self.orderType == .newOrders){
            tableViewheight = itemTableViewCellHeight * newOrdersArray[indexPath.section].dishes.count
        }
        else if(self.orderType == .ongoingOrder){
            tableViewheight = itemTableViewCellHeight * ongoingOrderArray[indexPath.section].dishes.count
        }
        else if(self.orderType == .pastOrder){
            tableViewheight = itemTableViewCellHeight * pastOrderArray[indexPath.section].dishes.count
        }
        let finalHeight = CGFloat(120 + tableViewheight)
        return finalHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}

extension AllOrdersVC:OrderTVCDelegate{
    func acceptOrderButtonActionDelegateWithTag(tag: Int) {
        let order = self.newOrdersArray[tag]
        callingChangeOrderStatusApi(orderStatus: .accept, order: order)
    }
    
    func rejectOrderButtonActionDelegateWithTag(tag: Int) {
        self.selectedIndex = tag
        self.commentView.isHidden = false
    }
    
    func viewDetailButtonActionDelegateWithTag(tag: Int) {
        let orderDetailPageVC = OrderDetailPageVC.init(nibName: "OrderDetailPageVC", bundle: nil)
        orderDetailPageVC.delegate = self
        orderDetailPageVC.orderType = self.orderType
        if (self.orderType == .newOrders){
            orderDetailPageVC.orderDetails = newOrdersArray[tag]
        }
        else if(self.orderType == .ongoingOrder){
            orderDetailPageVC.orderDetails = ongoingOrderArray[tag]
        }
        else if(self.orderType == .pastOrder){
           orderDetailPageVC.orderDetails = pastOrderArray[tag]
        }
        self.navigationController?.pushViewController(orderDetailPageVC, animated: true)
    }
    
    func callingChangeOrderStatusApi(orderStatus:OrderStatus,order:Order){
        let progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.label.text = "Loading".localiz()
        CartManager().changeOrderStatusApi(with: getChangeStatusRequestBody(orderStatus: orderStatus,order: order), success: { (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? ChangeOrderStatusResponseModel{
                if (model.status == "true"){
                    self.callingAllOrdersApi()
                    if (orderStatus == .reject){
                        self.commentView.isHidden = true
                    }
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
            if let comm = self.commentTextView.text{
                commentString = commentString + comm
            }
        }
        let orderStatus:String = "Status=\(ordStatus)"
        dataString = dataString + orderStatus + "&"
        
        dataString = dataString + commentString
        return dataString
    }
}

extension AllOrdersVC:OrderDetailDelegate {
    func orderCompletedDelegate() {
        callingAllOrdersApi()
    }
}
