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
    
    
    var idList = List<Schedule>()
    var scheduleList = List<Schedule>()
  
    let schedule = Schedule()
 var scheduleContents: Results<Schedule>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        // Do any additional setup after loading the view.
        
        do{
            let realm = try! Realm()
//            let realmTrip = RealmTrip()
//            let schedule = Schedule()
            
            scheduleContents  = realm.objects(Schedule.self)
            tableView.reloadData()
            
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        cell?.backgroundColor = UIColor.red
        
        
        if let cell = cell as? TableViewCell {
            print(idList)
            let scheduleIndex = idList[indexPath.row]
            print(scheduleIndex)
            
            cell.scheduleTime?.text = scheduleIndex.startTime + "〜" + scheduleIndex.endTime
            cell.scheduleTitle.text = scheduleIndex.scheduleTitle
            
            
            
        }
        return cell!
        
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

