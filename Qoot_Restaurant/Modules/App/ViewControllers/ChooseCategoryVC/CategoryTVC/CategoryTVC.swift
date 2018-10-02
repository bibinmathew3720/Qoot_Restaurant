//
//  CategoryTVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class CategoryTVC: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCategoryDetails(catDetails:Categories,index:IndexPath){
        categoryLabel.text = catDetails.subCategories[index.row].subCatName + " (\(catDetails.categoryName))"
    }
    
}
