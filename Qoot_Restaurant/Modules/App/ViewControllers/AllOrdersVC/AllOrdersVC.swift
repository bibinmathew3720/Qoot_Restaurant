//
//  AllOrdersVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 2/28/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit
class AllOrdersVC: BaseViewController {
    @IBOutlet weak var orderHeadingCV: UICollectionView!
    @IBOutlet weak var orderListTV: UITableView!
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
         orderListTV.register(UINib.init(nibName: "ManuTVC", bundle: nil), forCellReuseIdentifier: "menuTVC")
    }
    
    func localization(){
        self.title = "MyOrders".localiz()
    }
    
    func setUpCollectionView(){
        orderHeadingCV.register(UINib(nibName: "OrdersHeadingCVC", bundle: nil), forCellWithReuseIdentifier:"orderHeadingCell" )
    }
    
    func callingAllOrdersApi(){
        CartManager().callingGetOrderListApi(with: getAllOrdersRequestBody(), success: { (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootOrderHistoryResponseModel{
                
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 200, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: Collection Cell Delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AllOrdersVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTVC", for: indexPath) as!ManuTVC
        cell.tag = indexPath.row
        return cell
    }
}
