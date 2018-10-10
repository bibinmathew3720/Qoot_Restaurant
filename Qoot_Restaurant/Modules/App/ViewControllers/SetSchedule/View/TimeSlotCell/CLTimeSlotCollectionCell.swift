//
//  CLTimeSlotCollectionCell.swift
//  Benchr
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

class CLTimeSlotCollectionCell: UICollectionViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeLabel.text = ""
    }
    
    func setModel(model:CLTimeSlotModel) -> () {
        timeLabel.text = model.startTime + "-" + model.endTime
        if !model.isAvaialable{
            containerView.backgroundColor = UIColor(red:0.00, green:0.45, blue:0.74, alpha:0.5)
            timeLabel.textColor =  UIColor.white
        }else{
            containerView.backgroundColor = UIColor.white
            timeLabel.textColor = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
        }
    }
    
    func setCellDetails(index: Int , selectedIndex: Int){
        if index == selectedIndex{
            containerView.backgroundColor = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
            timeLabel.textColor =  UIColor.white
        }
        else{
            containerView.backgroundColor = UIColor.white
            timeLabel.textColor = UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)    }
    }
}
