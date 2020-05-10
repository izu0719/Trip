//
//  Date.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/05/10.
//  Copyright © 2020 mycompany. All rights reserved.
//

import Foundation
import UIKit


 let format: DateFormatter = {
    let format: DateFormatter = DateFormatter()
    format.timeZone = TimeZone.current
    format.locale = Locale(identifier: "en_US_POSIX")
    format.calendar = Calendar(identifier: .gregorian)
     format.dateFormat = "yyyy/MM/dd"
    return format
}()

extension Date {

   
}
