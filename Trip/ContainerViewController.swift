//
//  ContainerViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/05/08.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class ContainerViewController: UIViewController {

    let realm = try! Realm()
      let realmTrip = RealmTrip()
    var dateList = List<String>()
    var idList = List<Schedule>()
    var idRealmTrip = RealmTrip()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "AddSchedule" {
               let addScheduleViewController: AddScheduleViewController = segue.destination as! AddScheduleViewController
               
    
               
               addScheduleViewController.idList = idList
               addScheduleViewController.dateList = dateList
               addScheduleViewController.idRealmTrip = idRealmTrip
               

           }
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
