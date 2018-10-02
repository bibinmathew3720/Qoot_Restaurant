//
//  ChooseCategoryVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class ChooseCategoryVC: BaseViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    override func initView() {
        super.initView()
        initialisation()
        localisation()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
