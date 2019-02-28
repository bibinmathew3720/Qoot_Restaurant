//
//  ItemDetailTableCell.swift
//  Qoot
//
//  Created by Vishnu KM on 07/08/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class ItemDetailTableCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var quantityHeadingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDishes(dish:Dishes){
        self.itemNameLabel.text = dish.OrderName
        self.quantityHeadingLabel.text = "QTY".localiz() + " \(dish.OrderQuantity)"
        self.priceLabel.text = "SAR".localiz() + " " + "\(dish.OrderAmount)" + "/-"
    }
    
}
