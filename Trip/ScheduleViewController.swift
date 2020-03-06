//
//  ScheduleViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/28.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet var tableView: UITableView!
    
    
    let realm = try! Realm()
    let realmTrip = RealmTrip()
     var RealmTripList: Results<RealmTrip>!
    
    //VCからもらってきたList
    var idList = List<Schedule>()
    
   
    
    let schedule = Schedule()
    var scheduleContents: Results<Schedule>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        // Do any additional setup after loading the view.
        
        
        let realm = try! Realm()
        //            let realmTrip = RealmTrip()
        //            let schedule = Schedule()
        
        scheduleContents  = realm.objects(Schedule.self)
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return idList.count
       // return RealmTripList[tripId].scheduleList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        cell?.backgroundColor = UIColor.red
        
        
        if let cell = cell as? TableViewCell {
            
           let scheduleIndex = idList[indexPath.row]
//            print(scheduleIndex)
            
     //       let scheduleIndex = RealmTripList?[tripId].scheduleList[indexPath.row]
            
            cell.scheduleTime?.text = scheduleIndex.startTime + "〜" + scheduleIndex.endTime
            cell.scheduleTitle?.text = scheduleIndex.scheduleTitle
            
            
            
        }
        return cell!
        
    }
    
    
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "AddSchedule", sender: idList)
//
//
//        //        scheduleViewController.idList = idRealmTrip.scheduleList
//        //
//        //        print(scheduleViewController.idList)
//    }

//         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//              performSegue(withIdentifier: "AddSchedule", sender: tripId)
//    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "AddSchedule" {
            let addScheduleViewController: AddScheduleViewController = segue.destination as! AddScheduleViewController

           // let tripId = sender as! Int
           // let idList = sender as! List<Schedule>

          //  addScheduleViewController.tripId = tripId
            
           addScheduleViewController.idList = idList
            //
            //            print(scheduleViewController.idList)
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

