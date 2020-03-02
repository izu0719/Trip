//
//  AddTripViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/28.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class AddTripViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = "タイトル"
        // Do any additional setup after loading the view.
        
        
    }
    

    //保存
    @IBAction func save(){
        do{
            let realm = try! Realm()
            let realmTrip = RealmTrip()
            
            
            realmTrip.title = titleTextField.text!
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
            
            realmTrip.startDate = format.string(from: startDatePicker.date)
            realmTrip.endDate = format.string(from: endDatePicker.date)
            
            try! realm.write{
                realm.add(realmTrip)
                print(realmTrip.endDate)
                
            }
            
          
        }
       
        self.dismiss(animated: true, completion: nil)

       
        
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
