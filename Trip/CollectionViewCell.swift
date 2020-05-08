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
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    let realm = try! Realm()
           let realmTrip = RealmTrip()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gradient()
        
      backgroundImageView!.layer.cornerRadius = 12
        gradientView!.layer.cornerRadius = 12
    }
    
    func gradient() {
   //グラデーションの開始色
   let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:0)
   //グラデーションの開始色
        let bottomColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)

   //グラデーションの色を配列で管理
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]

   //グラデーションレイヤーを作成
   let gradientLayer: CAGradientLayer = CAGradientLayer()

   //グラデーションの色をレイヤーに割り当てる
   gradientLayer.colors = gradientColors
   //グラデーションレイヤーをスクリーンサイズにする
        gradientLayer.frame = self.gradientView!.bounds
       
        gradientLayer.cornerRadius = 12
   //グラデーションレイヤーをビューの一番下に配置
        self.gradientView!.layer.insertSublayer(gradientLayer, at: 2)
    }

}
