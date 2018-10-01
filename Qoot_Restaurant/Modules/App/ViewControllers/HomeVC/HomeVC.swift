//
//  HomeVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 9/30/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    let homeDataArray = ["TotalVisitors".localiz(),"VisitorsOnline".localiz(),"EarnedToday".localiz(),"QootBalance".localiz(),"TodaysMenu".localiz(),"TodaysOrder".localiz(),"OrderCalendar".localiz(),"AddNewDish".localiz()]
    override func initView() {
        super.initView()
        initialisation()
        localization()
    }
    
    func initialisation(){
        addingLeftBarButton()
        self.leftButton?.setImage(UIImage(named: "hamburger"), for: UIControlState.normal)
        setUpCollectionView()
    }
    
    func localization(){
      self.title = "KitchenHome".localiz()
    }
    
    func setUpCollectionView(){
        homeCollectionView.register(UINib(nibName: "HomeCVC", bundle: nil), forCellWithReuseIdentifier:"homeCell" )
    }
    
    override func leftNavButtonAction() {
        if LanguageManger.shared.currentLanguage == .en {
            self.slideMenuController()?.openLeft()
        }
        else{
            self.slideMenuController()?.openRight()
        }
    }
    
    @IBAction func statusSwitchAction(_ sender: UISwitch) {
        settingStatusSwitchPopup(withSwitch: sender)
    }
    func settingStatusSwitchPopup(withSwitch:UISwitch){
        let alertController = UIAlertController(title: "AreYouSure".localiz(), message: "ChangeKitchenOpenStatus".localiz(), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES".localiz(), style: .default) { (action:UIAlertAction) in
          
        }
        let noAction = UIAlertAction(title: "NO".localiz(), style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true) {
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    //MARK- Collection View Datasources
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return homeDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCVC
        cell.subHeadingLabel.text = homeDataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (collectionView.frame.size.width - 10)/2, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: Collection Cell Delegates
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
