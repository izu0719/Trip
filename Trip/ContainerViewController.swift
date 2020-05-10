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
    
    @IBOutlet var editButton: UIButton!
    lazy var barButton: UIBarButtonItem = UIBarButtonItem.init(customView: editButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.navigationItem.title = idRealmTrip.title
        
         dateList = idRealmTrip.dateList
        // Do any additional setup after loading the view.
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
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "AddSchedule" {
               let addScheduleViewController: AddScheduleViewController = segue.destination as! AddScheduleViewController
               
    
               
               addScheduleViewController.idList = idList
               addScheduleViewController.dateList = dateList
               addScheduleViewController.idRealmTrip = idRealmTrip
               

           }else if segue.identifier == "Schedule" {
                  let scheduleViewController: ScheduleViewController = segue.destination as! ScheduleViewController

              //    let idRealmTrip = sender as! RealmTrip

                  scheduleViewController.idRealmTrip = idRealmTrip
                  scheduleViewController.idList = idRealmTrip.scheduleList

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
