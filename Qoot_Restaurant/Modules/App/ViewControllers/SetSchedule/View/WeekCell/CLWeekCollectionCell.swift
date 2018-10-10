//
//  CLWeekCollectionCell.swift
//  Benchr
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Albin Joseph. All rights reserved.
//

import UIKit

class CLWeekCollectionCell: UICollectionViewCell {
    @IBOutlet var weekLabel: UILabel!
    @IBOutlet var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setCellDetails(index: Int , selectedIndex: Int){
        if index == selectedIndex{
            containerView.backgroundColor = .white
            weekLabel.textColor = .black
        } else {
            self.containerView.backgroundColor = .clear
            self.weekLabel.textColor = UIColor.lightGray
        }
    }
}
