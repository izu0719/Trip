//
//  TableViewCell.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/03/02.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewCell: UITableViewCell {

    @IBOutlet var scheduleTime: UILabel!
    @IBOutlet var scheduleTitle: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
