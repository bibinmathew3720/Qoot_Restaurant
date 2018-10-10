//
//  CLTimeScheduleTableViewCell.swift
//  6thWand
//
//  Created by Albin Joseph on 13/09/18.
//  Copyright © 2018 Codelynks. All rights reserved.
//

import UIKit
protocol CLTimeScheduleTableViewCellDelegate {
    func getSelectedSlot(_ selectedIndex:Int) -> ()
}
class CLTimeScheduleTableViewCell: UITableViewCell {
    @IBOutlet var timeSlotCollectionView: UICollectionView!
    var cLTimeSlotsModel:CLTimeSlotsModel?
    var selectedIndex:Int = 0
    var selectedTimeIndex:Int = -1
    var delegate:CLTimeScheduleTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewInitialisation()
        timeSlotCollectionView.setNeedsLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionViewInitialisation(){
        timeSlotCollectionView.register(UINib(nibName: "CLTimeSlotCollectionCell", bundle: nil), forCellWithReuseIdentifier:"timeSlotCell" )
        if let timeLayout = timeSlotCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = CGFloat((UIScreen.main.bounds.width/2)-10)
            let itemHeight = CGFloat(60.0)
            timeLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
        timeSlotCollectionView.isScrollEnabled = false
    }
    
}


extension CLTimeScheduleTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _model = cLTimeSlotsModel else{
            return 0
        }
        return _model.cLTimeSlotModel.count;
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let timeSlotCell:CLTimeSlotCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeSlotCell", for: indexPath) as! CLTimeSlotCollectionCell
            guard let _model = cLTimeSlotsModel else{
                return timeSlotCell
            }
            timeSlotCell.setModel(model: _model.cLTimeSlotModel[indexPath.row])
            timeSlotCell.containerView.layer.borderWidth = 1.0;
            //timeSlotCell.containerView.layer.borderColor = AppColor.themeBlue.cgColor
        if indexPath.row == selectedIndex{
            //timeSlotCell.containerView.backgroundColor = AppColor.themeBlue
                //UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
            timeSlotCell.timeLabel.textColor =  UIColor.white
        }
        else if(!_model.cLTimeSlotModel[indexPath.row].isAvaialable){
            timeSlotCell.containerView.backgroundColor = UIColor.white//UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
            timeSlotCell.timeLabel.textColor = UIColor.lightGray
            timeSlotCell.containerView.layer.borderColor = UIColor.lightGray.cgColor
        }
        else{
            timeSlotCell.containerView.backgroundColor = UIColor.white
           // timeSlotCell.timeLabel.textColor = AppColor.themeBlue
                //UIColor(red:0.00, green:0.45, blue:0.74, alpha:1.0)
            
        }
        //timeSlotCell.setCellDetails(index: indexPath.row, selectedIndex: selectedTimeIndex)
        return timeSlotCell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _model = cLTimeSlotsModel else {
            return
        }
        if _model.cLTimeSlotModel[indexPath.row].isAvaialable{
            selectedIndex = indexPath.row
            guard let _delegate = delegate else {
                return
            }
            _delegate.getSelectedSlot(indexPath.row)
            self.timeSlotCollectionView.reloadData()
        }else{
//            CLUtility.showDefaultAlertwith(_message: bookSlot.slotsNotAvailable, parentController: self.parentContainerViewController()!)
            self.timeSlotCollectionView.reloadData()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let _model = cLTimeSlotsModel else{
            return CGSize.init()
        }
//        let slotData:CLTimeSlotModel = _model.cLTimeSlotModel[indexPath.row]
//        let myString = slotData.startTime + "-" + slotData.endTime
//        let size: CGSize = myString.size(withAttributes: [NSAttributedStringKey.font: UIFont.init(name: AppFont.REGULAR, size: 14) as Any])
//        let finalSize = CGSize(width: size.width + 24, height: size.height + 30)
        let itemWidth = CGFloat((UIScreen.main.bounds.width/2)-10)
        let itemHeight = CGFloat(50.0)
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
}
