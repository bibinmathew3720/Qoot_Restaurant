//
//  AddNewDishVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class AddNewDishVC: BaseViewController {
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameTF: UITextField!
    @IBOutlet weak var dishDesTextView: UITextView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var preparationTimeTF: UITextField!
    @IBOutlet weak var addCategoriesButton: UIButton!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var addNewDishButton: UIButton!
    
    override func initView() {
        super.initView()
        initialisation()
        localisation()
    }
    
    func initialisation(){
       addingLeftBarButton()
    }
    
    func localisation(){
       self.title = "AddNewDish".localiz()
       dishNameTF.placeholder = "EnterDishNamePlaceholder".localiz()
       dishDesTextView.toolbarPlaceholder = "WriteDescriptionPlaceholder".localiz()
       preparationTimeLabel.text = "ChoosePreparationTime".localiz()
       addCategoriesButton.setTitle("AddCategories".localiz(), for: UIControlState.normal)
       addNewDishButton.setTitle("ADDNEWDISH".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCategoriesButtonAction(_ sender: UIButton) {
        let chooseCategoryVC = ChooseCategoryVC.init(nibName: "ChooseCategoryVC", bundle: nil)
        self.navigationController?.pushViewController(chooseCategoryVC, animated: true)
    }
    @IBAction func addNewDishButtonAction(_ sender: UIButton) {
       
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
