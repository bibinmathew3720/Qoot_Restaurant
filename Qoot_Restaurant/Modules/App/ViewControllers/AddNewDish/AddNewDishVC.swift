//
//  AddNewDishVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class AddNewDishVC: BaseViewController {
    @IBOutlet var timeSlotToolBar: UIToolbar!
    @IBOutlet var timeSlotsPickerView: UIPickerView!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameTF: UITextField!
    @IBOutlet weak var dishNameArabic: UITextField!
    @IBOutlet weak var dishDesTextView: UITextView!
    @IBOutlet weak var dishDesArabicTV: UITextView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var preparationTimeTF: UITextField!
    @IBOutlet weak var addCategoriesButton: UIButton!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var addNewDishButton: UIButton!
    var subCatArray = [SubCategory]()
    var preparationTimeResponse:PreparationTimesResponseModel?
    var selPrepTime:PreparationTime?
    override func initView() {
        super.initView()
        initialisation()
        localisation()
        callingGetPreparationTimesApi()
    }
    
    func initialisation(){
       addingLeftBarButton()
       registerNib()
        self.preparationTimeTF.inputAccessoryView = self.timeSlotToolBar
        self.preparationTimeTF.inputView = self.timeSlotsPickerView
    }
    
    func localisation(){
       self.title = "AddNewDish".localiz()
       dishNameTF.placeholder = "EnterDishNamePlaceholder".localiz()
       dishDesTextView.toolbarPlaceholder = "WriteDescriptionPlaceholder".localiz()
       preparationTimeLabel.text = "ChoosePreparationTime".localiz()
       addCategoriesButton.setTitle("AddCategories".localiz(), for: UIControlState.normal)
       addNewDishButton.setTitle("ADDNEWDISH".localiz(), for: UIControlState.normal)
    }
    
    func registerNib() -> () {
        categoriesCV.register(UINib.init(nibName: "CLKeyWordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CLKeyWordCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCategoriesButtonAction(_ sender: UIButton) {
        let chooseCategoryVC = ChooseCategoryVC.init(nibName: "ChooseCategoryVC", bundle: nil)
        chooseCategoryVC.delegate = self
        self.navigationController?.pushViewController(chooseCategoryVC, animated: true)
    }
    
    @IBAction func addNewDishButtonAction(_ sender: UIButton) {
        if isValidDishDetails(){
            
        }
       
    }
    
    @IBAction func toolBarDoneButtonAction(_ sender: UIBarButtonItem) {
        self.selPrepTime = self.preparationTimeResponse?.prepTimes[self.timeSlotsPickerView.selectedRow(inComponent: 0)]
        if let prepTime = self.selPrepTime{
            self.preparationTimeTF.text = prepTime.time
        }
        self.view.endEditing(true)
    }
    
    @IBAction func toolBarCancelButtonAction(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    
    func isValidDishDetails()->Bool{
        var isValid = true
        var messageString = ""
        if subCatArray.count == 0 {
            messageString = "ADDFOODCATEGORY".localiz()
            isValid = false
        }
        else{
            if let selTime = self.selPrepTime{
                if let dishNameText = self.dishNameTF.text{
                    if dishNameText.count == 0{
                        messageString = "FILLMANDATORYFIELDS".localiz()
                        isValid = false
                    }
                }
                else{
                    if let disNameArabic = self.dishNameArabic.text {
                        if disNameArabic.count == 0 {
                            messageString = "FILLMANDATORYFIELDS".localiz()
                            isValid = false
                        }
                    }
                    else{
                        if let disNameDes = self.dishDesTextView.text {
                            if disNameDes.count == 0 {
                                messageString = "FILLMANDATORYFIELDS".localiz()
                                isValid = false
                            }
                        }
                        else {
                            if let dishDesArabic = self.dishDesArabicTV.text {
                                if dishDesArabic.count == 0 {
                                    messageString = "FILLMANDATORYFIELDS".localiz()
                                    isValid = false
                                }
                            }
                        }
                    }
                }
            }
            else{
                messageString = "FILLMANDATORYFIELDS".localiz()
                isValid = false
            }
        }
        if !isValid{
           CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: messageString, parentController: self)
        }
        return isValid
    }
    
    //MARK: Get Preparation Times Api
    
    func  callingGetPreparationTimesApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingGetPreparationTimesApi(with: "", success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let model = model as? PreparationTimesResponseModel{
                self.preparationTimeResponse = model
                self.timeSlotsPickerView.reloadAllComponents()
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

extension AddNewDishVC:CategoryVCDelegate{
    func categoryVCDelegateAction(with selSubCat: SubCategory) {
        subCatArray.append(selSubCat)
        subCatArray = subCatArray.removingDuplicates(byKey: { $0.subCatIId})
        categoriesCV.reloadData()
        print(selSubCat)
    }
}

extension AddNewDishVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CLKeyWordCollectionViewCellDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return subCatArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLKeyWordCollectionViewCell", for: indexPath) as! CLKeyWordCollectionViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.setModelstr(self.subCatArray[indexPath.row].subCatName)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myString = self.subCatArray[indexPath.row].subCatName
        var size: CGSize = myString.size(withAttributes: [NSAttributedStringKey.font: UIFont.init(name: Constant.Font.Regular, size: 14) ?? UIFont.systemFont(ofSize: 14)])
        size.width = size.width + 30
        size.height = 30
        return size
    }
    
    func closeKeywordSelection(tag: Int) {
        subCatArray.remove(at: tag)
        self.categoriesCV.reloadData()
    }
}

extension AddNewDishVC:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let prepTimeRepsonse = self.preparationTimeResponse{
            return prepTimeRepsonse.prepTimes.count
        }
       return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if let prepTimeRepsonse = self.preparationTimeResponse{
            return prepTimeRepsonse.prepTimes[row].time
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    }
}

