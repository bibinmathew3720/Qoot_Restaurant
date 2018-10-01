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
      self.title = "Qoot".localiz()
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
      
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCVC
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
