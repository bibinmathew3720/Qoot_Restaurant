//
//  AllOrdersVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 2/28/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

enum OrderType{
    case ongoingOrder
    case pastOrder
    case newOrders
}

class AllOrdersVC: BaseViewController {
    @IBOutlet weak var orderHeadingCV: UICollectionView!
    @IBOutlet weak var orderListTV: UITableView!
    @IBOutlet weak var nothingToShowLabel: UILabel!
    
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
         orderListTV.register(UINib.init(nibName: "OrderTVC", bundle: nil), forCellReuseIdentifier: "orderCell")
    }
    
    func localization(){
        self.title = "MyOrders".localiz()
        self.nothingToShowLabel.text = "NothingToShow".localiz()
    }
    
    func setUpCollectionView(){
        orderHeadingCV.register(UINib(nibName: "OrdersHeadingCVC", bundle: nil), forCellWithReuseIdentifier:"orderHeadingCell" )
    }
    
    func callingAllOrdersApi(){
         MBProgressHUD.showAdded(to: self.view, animated: true)
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
        }
        else if(self.orderType == .ongoingOrder){
            cell.setOrderDetails(orderDetail: ongoingOrderArray[indexPath.section])
        }
        else if(self.orderType == .pastOrder){
            cell.setOrderDetails(orderDetail: pastOrderArray[indexPath.section])
        }
        cell.tag = indexPath.section
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
