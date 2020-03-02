//
//  CollectionViewCell.swift
//  
//
//  Created by 坂本 泉 on 2020/03/01.
//

import UIKit
import RealmSwift

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let realm = try! Realm()
           let realmTrip = RealmTrip()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   

}
