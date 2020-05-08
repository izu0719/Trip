//
//  DetailScheduleViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/03/02.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class DetailScheduleViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var startTimeLabel: UILabel!
    @IBOutlet var endTimeLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    
    var detailSchedule = Schedule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = detailSchedule.scheduleTitle
        
        let format = DateFormatter()
        let timeFormat = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        
        timeFormat.locale = NSLocale.system
        timeFormat.setLocalizedDateFormatFromTemplate("jm")
        
        let startTimeText = timeFormat.string(from: detailSchedule.startTime)
        let endTimeText = timeFormat.string(from: detailSchedule.endTime)
        
        let dateText = detailSchedule.date
        
        dateLabel.text = dateText
        startTimeLabel.text = startTimeText
        endTimeLabel.text = endTimeText
        placeLabel.text = detailSchedule.place
        memoLabel.text = detailSchedule.memo
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
