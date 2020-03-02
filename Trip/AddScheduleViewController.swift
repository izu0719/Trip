//
//  AddScheduleViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/28.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class AddScheduleViewController: UIViewController {

    @IBOutlet var scheduleTitleTextField: UITextField!
    @IBOutlet var scheduleDate: UIDatePicker!
    @IBOutlet var scheduleStartTime: UIDatePicker!
    @IBOutlet var scheduleEndTime: UIDatePicker!
    @IBOutlet var schedulePlaceTextField: UITextField!
    @IBOutlet var scheduleMemoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let realm = try! Realm()
  
    
    @IBAction func save(){
        do{
            let realm = try! Realm()
         //   let realmTrip = RealmTrip()
            let schedule = Schedule()
            
            
            schedule.scheduleTitle = scheduleTitleTextField.text!
            let format = DateFormatter()
            format.dateStyle = .short
            format.timeStyle = .short
            
            schedule.date = format.string(from: scheduleDate.date)
            
      
            schedule.startTime = format.string(from: scheduleStartTime.date)
            schedule.endTime = format.string(from: scheduleEndTime.date)
            
            schedule.place = schedulePlaceTextField.text
            schedule.memo = scheduleMemoTextField.text
            
            
            try! realm.write{
                for realmTrip in realm.objects(RealmTrip.self) {
                realmTrip.scheduleList.append(schedule)
                print(realm.objects(RealmTrip.self))
                }
                
            }
          
        }
         // ViewController().test()
        self.dismiss(animated: true, completion: nil)
      
      //  ViewController.collectionView.reloadData()
     
        
    }
    
    //キャンセル
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
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
