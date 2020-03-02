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
    @objc dynamic var startDate = ""
    @objc dynamic var endDate = ""
    
    let scheduleList = List<Schedule>()
    
    override static func primaryKey() -> String? {
        return "id"
        
        
    }
}




class Schedule: Object{
    @objc dynamic var scheduleTitle = "タイトル"
    @objc dynamic var date: String!
    @objc dynamic var startTime: String!
    @objc dynamic var endTime: String!
    @objc dynamic var place: String!
    @objc dynamic var memo: String!
}




