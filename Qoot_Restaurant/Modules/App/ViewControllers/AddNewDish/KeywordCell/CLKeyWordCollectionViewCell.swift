//
//  CLKeyWordCollectionViewCell.swift
//  6thWand
//
//  Created by Albin Joseph on 06/08/18.
//  Copyright © 2018 Codelynks. All rights reserved.
//

import UIKit

protocol CLKeyWordCollectionViewCellDelegate {
    func closeKeywordSelection(tag:Int)
}

class CLKeyWordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var keyWordLabel: UILabel!
    var delegate:CLKeyWordCollectionViewCellDelegate?
    @IBOutlet weak var buttonClose: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1.0
        //self.layer.borderColor = UIColor.black as! CGColor
        //self.layer.borderColor = Constant.Colors.CommonBlackColor as! CGColor
    }

    func setModelstr(_ str:String) -> () {
        keyWordLabel.text = str
    }
    @IBAction func actionClose(_ sender: Any) {
        delegate?.closeKeywordSelection(tag: self.tag)
    }
}
