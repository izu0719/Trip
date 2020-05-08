//
//  NavigationViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/03/08.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //　ナビゲーションバーの背景色
               navigationBar.barTintColor = UIColor(hex: "35E6E0")
               // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
               navigationBar.tintColor = .white
               // ナビゲーションバーのテキストを変更する
               navigationBar.titleTextAttributes = [
                   // 文字の色
                   .foregroundColor: UIColor.white
               ]
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
