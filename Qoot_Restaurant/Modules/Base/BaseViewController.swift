//
//  BaseViewController.swift
//  Preparture
//
//  Created by praveen raj on 17/06/18.
//  Copyright © 2018 praveen raj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var leftButton:UIButton?
    var cartLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
    }
    //MARK: Adding Navigation Bar Buttons
    
    func addingLeftBarButton(){
        self.leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.leftButton?.addTarget(self, action: #selector(leftNavButtonAction), for: .touchUpInside)
        self.leftButton?.setImage(UIImage.init(named: Constant.ImageNames.backArrow), for: UIControlState.normal)
        var leftBarButton = UIBarButtonItem()
        leftBarButton = UIBarButtonItem.init(customView: self.leftButton!)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftNavButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func addFilterIcon()->UIBarButtonItem{
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        filterButton.setImage(UIImage.init(named: Constant.ImageNames.filterIcon), for: UIControlState.normal)
        var filterBarButton = UIBarButtonItem()
        filterBarButton = UIBarButtonItem.init(customView: filterButton)
        return filterBarButton
    }
    
    @objc func filterButtonAction(){
        
    }
    
    func addCartIconOnly()->UIBarButtonItem{
        let cartButtonView = UIButton(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        cartButtonView.setImage(UIImage.init(named: Constant.ImageNames.alarmIcon), for: .normal)
        cartButtonView.addTarget(self, action:  #selector(cartButtonAction), for: .touchUpInside)
        cartButtonView.contentMode = .scaleAspectFit
        
        cartLabel = UILabel(frame: CGRect.init(x: 15, y: -5, width: 20, height: 20))
        cartLabel?.backgroundColor = UIColor(red:1.00, green:0.87, blue:0.09, alpha:1.0)
        cartLabel?.textAlignment = .center
        cartLabel?.font = UIFont.init(name: Constant.Font.Regular, size: 12)
        cartLabel?.layer.cornerRadius = 10
        cartLabel?.clipsToBounds = true
        cartLabel?.text = ""
        //cartButtonView.addSubview(cartLabel!)
        let rightBarButton = UIBarButtonItem(customView: cartButtonView)
        self.navigationItem.rightBarButtonItems  = [rightBarButton]
        return rightBarButton
    }
    
    func addHomeIconAndFilterIcon(){
        let button1 = addFilterIcon()
        let button2 = addingHomeBarButton()
        self.navigationItem.rightBarButtonItems  = [button1,button2]
    }
    
    func addingHomeBarButton()->UIBarButtonItem{
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        homeButton.setImage(UIImage.init(named: Constant.ImageNames.homeIcon), for: UIControlState.normal)
        var homeBarButton = UIBarButtonItem()
        homeBarButton = UIBarButtonItem.init(customView: homeButton)
        self.navigationItem.rightBarButtonItems  = [homeBarButton]
        return homeBarButton
    }
    
    @objc func homeButtonAction(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func cartButtonAction(){
        let notVC = NotificationVC(nibName: "NotificationVC", bundle: nil)
        let notificationNavCntlr = UINavigationController.init(rootViewController: notVC)
        self.present(notificationNavCntlr, animated: true, completion: nil)
    }
    
    
    
    //MARK: Adding Shadow View
    
    func addShadowToAView(shadowView:UIView){
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
