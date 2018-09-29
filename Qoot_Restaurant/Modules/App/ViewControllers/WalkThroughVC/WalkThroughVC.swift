//
//  WalkThroughVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/15/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class WalkThroughVC: BaseViewController {
    @IBOutlet weak var walkThroughCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var gotitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        localisation()
        walkThroughCV.register(UINib(nibName: "WalkThroughCVC", bundle: nil), forCellWithReuseIdentifier:"walkThroughCell" )

        // Do any additional setup after loading the view.
    }
    
    func localisation(){
        gotitButton.setTitle("GOTIT".localiz(), for: UIControlState.normal)
        skipButton.setTitle("SKIP".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        setHomePage()
    }
    
    @IBAction func gotItButtonAction(_ sender: UIButton) {
        setHomePage()
    }
    
    func setHomePage(){
        UserDefaults.standard.set(true, forKey: Constant.VariableNames.isSecondLogIn)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
       appDelegate.initWindow()
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

extension WalkThroughVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WalkThroughCVC = collectionView.dequeueReusableCell(withReuseIdentifier: "walkThroughCell", for: indexPath) as! WalkThroughCVC
        if indexPath.row == 0 {
            cell.backView.backgroundColor = Constant.Colors.CommonRedColor
            cell.imageView.image = UIImage.init(named: "walkThrough1")
            cell.headingLabel.text = "Walkthrough1_Title".localiz()
            cell.subHeadinglabel.text = "Walkthrough1_SubTitle".localiz()
        }
        else if indexPath.row == 1 {
           cell.backView.backgroundColor = Constant.Colors.CommonGreyColor
            cell.imageView.image = UIImage.init(named: "walkThrough2")
            cell.headingLabel.text = "Walkthrough2_Title".localiz()
            cell.subHeadinglabel.text = "Walkthrough2_SubTitle".localiz()
        }
        else if indexPath.row == 2 {
            cell.backView.backgroundColor = Constant.Colors.CommonGreenColor
            cell.imageView.image = UIImage.init(named: "walkThrough3")
            cell.headingLabel.text = "Walkthrough3_Title".localiz()
            cell.subHeadinglabel.text = "Walkthrough3_SubTitle".localiz()
        }
        else if indexPath.row == 3 {
            cell.backView.backgroundColor = Constant.Colors.CommonMeroonColor
            cell.imageView.image = UIImage.init(named: "walkThrough4")
            cell.headingLabel.text = "Walkthrough4_Title".localiz()
            cell.subHeadinglabel.text = "Walkthrough4_SubTitle".localiz()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK:- UIScrollView Delegate Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        if pageNumber == 3{
            gotitButton.isHidden = false
        }
        else{
           gotitButton.isHidden = true
        }
        
    }
    
}


