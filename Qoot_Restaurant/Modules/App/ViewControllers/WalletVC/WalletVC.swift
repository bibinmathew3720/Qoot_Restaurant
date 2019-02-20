//
//  WalletVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 2/20/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class WalletVC: BaseViewController {
    @IBOutlet weak var turnoverHeadingLabel: UILabel!
    @IBOutlet weak var receivedAmountHeadingLabel: UILabel!
    @IBOutlet weak var qootBalanceHeadingLabel: UILabel!
    @IBOutlet weak var paymenthistoryLabel: UILabel!
    @IBOutlet weak var paymentHistorytableView: UITableView!
    var walletDetailsResponse:WalletDetailsResponseModel?
    override func initView() {
        super.initView()
        initialisation()
        localization()
        getKitchenWalletDetailsApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
    }
    
    func localization(){
        self.title = "MyWallet".localiz()
        self.paymenthistoryLabel.text = "PaymentHistory".localiz()
    }
    
    func populateWalletDetails(){
        if let walletDetails = self.walletDetailsResponse{
            turnoverHeadingLabel.text = "TurnOver".localiz() + " :" + "SAR".localiz() + " \(walletDetails.turnOver)"
            receivedAmountHeadingLabel.text = "ReceivedAmount".localiz() + " :" + "SAR".localiz() + " \(walletDetails.receivedAmount)"
            qootBalanceHeadingLabel.text = "QootBalance".localiz() + " :" + "SAR".localiz() + " \(walletDetails.qootBalance)"
            self.paymentHistorytableView.reloadData()
        }
    }
    
    //MARK: Get Kitchen Wallet Details Api
    
    func  getKitchenWalletDetailsApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetWalletDetailsApi(with: getWalletRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? WalletDetailsResponseModel{
                self.walletDetailsResponse = model
                self.populateWalletDetails()
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
    
    func getWalletRequestBody()->String{
        var dataString:String = ""
        if let user = User.getUser(){
            let kitchenIdString:String = "KitchenId=\(user.kitchenId)"
            dataString = kitchenIdString
        }
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
