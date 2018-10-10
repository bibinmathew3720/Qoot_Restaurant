//
//  CLCalanderTableViewCell.swift
//  6thWand
//
//  Created by Albin Joseph on 13/09/18.
//  Copyright © 2018 Codelynks. All rights reserved.
//

import UIKit

protocol CLCalanderTableViewCellDelegate {
    func getSelectedDate(_ dateString:String) -> ()
}

class CLCalanderTableViewCell: UITableViewCell {
    weak var calendar: FSCalendar!
    var delegate:CLCalanderTableViewCellDelegate?
    var selectedDate:String = ""
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
       // formatter.dateFormat = dateFormat.yyyy_MM_dd
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let calendar = FSCalendar(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        self.addSubview(calendar)
        self.calendar = calendar
        self.calendar.scope = .month
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension CLCalanderTableViewCell:FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        //self.calendarHeightConstraint.constant = bounds.size.height
        self.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        selectedDate = self.dateFormatter.string(from: date)
        guard let _delegate = delegate else {
            return
        }
        _delegate.getSelectedDate(selectedDate)
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
}
