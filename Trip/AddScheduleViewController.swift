//
//  AddScheduleViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/28.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class AddScheduleViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scheduleTitleTextField: UITextField!
    @IBOutlet var scheduleDate: UIDatePicker!
    @IBOutlet var scheduleStartTime: UIDatePicker!
    @IBOutlet var scheduleEndTime: UIDatePicker!
    @IBOutlet var schedulePlaceTextField: UITextField!
    @IBOutlet var scheduleMemoTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    
    let realm = try! Realm()
    var idList = List<Schedule>()
    var RealmTripList: Results<RealmTrip>!
    let sortedList = List<Schedule>()
      var dateList = List<String>()
    
     var idRealmTrip = RealmTrip()
       
       let schedule = Schedule()
       var scheduleContents: Results<Schedule>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
             self.scheduleTitleTextField.delegate = self
        self.schedulePlaceTextField.delegate = self
        self.scheduleMemoTextField.delegate = self
        saveButton.layer.cornerRadius = 25
        cancelButton.layer.cornerRadius = 25
        saveButton.backgroundColor = UIColor(hex: "35E6E0")
        
        let format = DateFormatter()
                           format.dateFormat = "yyyy/MM/dd"
        
      
        scheduleDate.minimumDate = idRealmTrip.startDate
        scheduleDate.maximumDate = idRealmTrip.endDate
        // Do any additional setup after loading the view.
    }

       
    
    
    @IBAction func save(){
        
            let realm = try! Realm()
            let realmTrip = RealmTrip()
            let schedule = Schedule()
            
            
            
            //Date
            schedule.scheduleTitle = scheduleTitleTextField.text!
            
          
            
            let format = DateFormatter()
                       format.dateFormat = "yyyy/MM/dd"
//        scheduleDate.minimumDate = dateList[0].date
    

        schedule.date = format.string(from: scheduleDate.date)
           
            schedule.startTime = scheduleStartTime.date
            schedule.endTime = scheduleEndTime.date
            //schedule.endTime = timeFormat.string(from: scheduleEndTime.date)

            
            print(schedule.startTime)
            
            schedule.place = schedulePlaceTextField.text!
            schedule.memo = scheduleMemoTextField.text!
            
            
             
            
            try! realm.write{
                
                idList.append(schedule)
                print(idList)
                
            }
            

     
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    //キャンセル
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            scheduleTitleTextField.resignFirstResponder()
        schedulePlaceTextField.resignFirstResponder()
        scheduleMemoTextField.resignFirstResponder()
            return true
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


