//
//  ChooseCategoryVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
protocol CategoryVCDelegate {
    func categoryVCDelegateAction(with selSubCat:SubCategory) -> ()
}
class ChooseCategoryVC: BaseViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    var catResponseModel:QootCategoriesResponseModel?
    var delegate:CategoryVCDelegate?
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        callingGetCategoriesApi()
    }
    
    func initialisation(){
        addingLeftBarButton()
        categoryTableView.estimatedRowHeight = 100
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        registerCell()
    }
    
    func registerCell(){
        categoryTableView.register(UINib.init(nibName: "CategoryTVC", bundle: nil), forCellReuseIdentifier: "categoryCell")
    }
    
    func localisation(){
        self.title = "ChooseACategory".localiz()
    }
    
    //MARK: View Online Status Api
    
    func  callingGetCategoriesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetCategoriesApi(with: "", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? QootCategoriesResponseModel{
                self.catResponseModel = model
                self.categoryTableView.reloadData()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChooseCategoryVC : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let catResponse = self.catResponseModel{
            return catResponse.categories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let catResponse = self.catResponseModel{
            return catResponse.categories[section].subCategories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTVC
        if let categoryResponse = self.catResponseModel{
            cell.setCategoryDetails(catDetails:categoryResponse.categories[indexPath.section],index:indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _delegate = delegate else {
            return
        }
        if let categoryResponse = self.catResponseModel{
            _delegate.categoryVCDelegateAction(with: categoryResponse.categories[indexPath.section].subCategories[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
}
