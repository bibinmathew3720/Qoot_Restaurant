//
//  NotificationsTVC.swift
//  Qoot_Restaurant
//
//  Created by Bibin Mathew on 10/7/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit

class NotificationsTVC: UITableViewCell {
    @IBOutlet weak var refNoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNotificationDetails(notification:Notifications){
        refNoLabel.text = "RefNo".localiz() + " \(notification.notificationSourceId)"
        dateLabel.text = notification.notificationDate
        notDescLabel.text = notification.notificationMessage
    }
    
}
