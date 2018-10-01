//
//  HomeCVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/1/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class HomeCVC: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDashBoardDetails(dashBoardDetails:DashboardResponseModel){
        self.headingLabel.isHidden = false
        if self.tag == 0{
            headingLabel.textColor = Constant.Colors.CommonPinkColor
            headingLabel.text = "\(dashBoardDetails.totalVisitors)"
        }
        else if self.tag == 1 {
             headingLabel.textColor = Constant.Colors.CommonPinkColor
             headingLabel.text = "\(dashBoardDetails.visitorsOnline)"
        }
        else if self.tag == 2 {
            headingLabel.text = "SAR".localiz() + " " + String (format: "%0.1f", dashBoardDetails.todayEarn)
        }
        else if self.tag == 3 {
            headingLabel.text = "SAR".localiz() + " " + String (format: "%0.1f", dashBoardDetails.qootBalance)
        }
        else{
            self.headingLabel.isHidden = true
        }
        
    }

}
