//
//  ItemDetailHeadingTVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 3/2/19.
//  Copyright © 2019 Cl. All rights reserved.
//

import UIKit

class ItemDetailHeadingTVC: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localization()
        // Initialization code
    }
    
    func localization(){
        self.itemsLabel.text = "Items".localiz()
        self.quantityLabel.text = "Quantity".localiz()
        self.priceLabel.text = "Price".localiz()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
