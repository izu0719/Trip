//
//  RealmSwift.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/28.
//  Copyright © 2020 mycompany. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTrip: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var startDate: Date!
    @objc dynamic var endDate: Date!
    @objc dynamic var image: Data? = nil
    
    let scheduleList = List<Schedule>()
    var dateList = List<String>()
    
    let dateScheduleList = List<DateSchedule>()
    
    override static func primaryKey() -> String? {
        return "id"
        
        
    }
}

class DateSchedule: Object{
    @objc dynamic var date: Date!
    let scheduleList = List<Schedule>()
}


class Schedule: Object{
    @objc dynamic var scheduleTitle = "タイトル"
    @objc dynamic var date: String!
    @objc dynamic var startTime: Date!
    @objc dynamic var endTime: Date!
    @objc dynamic var place = ""
    @objc dynamic var memo = ""
}




