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
    @IBOutlet var editButton: UIBarButtonItem!
    
    
    let realm = try! Realm()
    let realmTrip = RealmTrip()
    var RealmTripList: Results<RealmTrip>!
    
    var dateList = List<String>()
    let dateScheduleList = List<DateSchedule>()
    //VCからもらってきたList
    var idList = List<Schedule>()
    var idRealmTrip = RealmTrip()
    
    let sortedList = List<Schedule>()
    
    
    let schedule = Schedule()
    var scheduleContents: Results<Schedule>!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = idRealmTrip.title
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        // Do any additional setup after loading the view.
        
        
        let realm = try! Realm()
        //            let realmTrip = RealmTrip()
        //            let schedule = Schedule()
        
        
        scheduleContents  = realm.objects(Schedule.self)
        
        
        
        let sortProperties = [
            SortDescriptor(keyPath: "date", ascending: true),
            SortDescriptor(keyPath: "startTime", ascending: true) ]
        
        
        scheduleContents! = idList.sorted(by: sortProperties)
        
        
        dateList = idRealmTrip.dateList
        date()
        print(filteredList)
        print(dateList)

    }
    
    override func viewWillAppear(_ animated: Bool) {
 
        tableView.reloadData()
    }
    
    
    
    
    //
    var sectionNum: Int!
    var filteredList = List<String>()
    
    var number: Int!
    
    var sectionName = Set<String>()
    
    func date() -> List<String> {
        let realm = try! Realm()
        sectionName = Set(realm.objects(Schedule.self).value(forKey: "date") as! [String])
        for date in sectionName{
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
            let  dateText = date
            filteredList.append(dateText)
            
            
        }
        return filteredList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scheduleContents.filter("date == %@", dateList[section]).count
 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var sectionTitle = "Day"
        return dateList[section]
    }
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        //        var numberOfSections: Int!
        //        if sortedList.count == 0{
        //            numberOfSections = 0
        //        }else{
        //            numberOfSections = filteredList.count
        //        }
        return dateList.count
        //filteredList.count
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        
        if let cell = cell as? TableViewCell {
            
            let scheduleIndex = scheduleContents.filter("date == %@", dateList[indexPath.section])[indexPath.row]
            
            
  
            let timeFormat = DateFormatter()
            
            
            timeFormat.locale = NSLocale.system
            timeFormat.setLocalizedDateFormatFromTemplate("jm")
            
            let startTimeText = timeFormat.string(from: scheduleIndex.startTime)
            let endTimeText = timeFormat.string(from: scheduleIndex.endTime)
            
            cell.scheduleTime?.text =  startTimeText + "〜" + endTimeText
            cell.scheduleTitle?.text = scheduleIndex.scheduleTitle
           // cell.scheduleTime?.textColor = UIColor(hex: "35E6E0")
            
            
            
        }
        return cell!
        
    }
    
    @IBAction func edit(){
        let alert: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let edit: UIAlertAction = UIAlertAction(title: "edit", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("edit")
        })
        let delete: UIAlertAction = UIAlertAction(title: "delete", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            
            self.deleteTrip()
            
            self.navigationController?.popViewController(animated: true)
            print("delete")
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("cancel")
        })
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //trip削除
    func deleteTrip(){
        try! realm.write{
            realm.delete(idRealmTrip)
        }
    }
    
    //削除
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            try! realm.write{
                realm.delete(scheduleContents.filter("date == %@", dateList[indexPath.section])[indexPath.row])
            }
            // arrayName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: scheduleContents.filter("date == %@", dateList[indexPath.section])[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddSchedule" {
            let addScheduleViewController: AddScheduleViewController = segue.destination as! AddScheduleViewController
            
 
            
            addScheduleViewController.idList = idList
            addScheduleViewController.dateList = dateList
            addScheduleViewController.idRealmTrip = idRealmTrip
            

        } else if segue.identifier ==  "Detail"{
            let detailScheduleViewController: DetailScheduleViewController = segue.destination as! DetailScheduleViewController
            detailScheduleViewController.detailSchedule = sender as! Schedule
            
        }else if segue.identifier ==  "Container"{
             let containerViewController: ContainerViewController = segue.destination as! ContainerViewController
                       
            
                       
                       containerViewController.idList = idList
                       containerViewController.dateList = dateList
                       containerViewController.idRealmTrip = idRealmTrip
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

