//
//  AddTripViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/28.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class AddTripViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    @IBOutlet var tripImage: UIImageView!
    
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var addImageButton: UIButton!
    
    
    var RealmTripList: Results<RealmTrip>!
     let realmTrip = RealmTrip()
    
       let dateList = List<String>()
    
    var imageData: Data? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleTextField.delegate = self
        
        saveButton.layer.cornerRadius = 25
        cancelButton.layer.cornerRadius = 25
        saveButton.backgroundColor = UIColor(hex: "35E6E0")
        
        titleTextField.text = ""
        
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func addImage(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            tripImage.contentMode = .scaleAspectFill
            tripImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
      func generateDates(between startDate: Date?, and endDate: Date?, byAdding: Calendar.Component) ->  List<String> {

          
          guard var date = realmTrip.startDate, let endDate = realmTrip.endDate else {
              return dateList
          }
        let format = DateFormatter()
       
          format.dateFormat = "yyyy/MM/dd"
          
         
        
        let dateText = format.string(from: date)
          dateList.append(dateText)
        if format.string(from: date) != format.string(from: endDate){
          
        
          while date < endDate {
              date = Calendar.current.date(byAdding: byAdding, value: 1, to: date)!
            let dateText = format.string(from: date)
              dateList.append(dateText)
            }
          }
          
          
          return dateList
          
        
      }
    
    
    //保存
    @IBAction func save(){
 
    
        
 if tripImage.image == nil {
     let title = "アラート"
            let message = "画像を追加してください"
            let okText = "OK"

     let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
     let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okayButton)

            present(alert, animated: true, completion: nil)
 }else{
            let realm = try! Realm()
           
            
            
            realmTrip.title = titleTextField.text!
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
      format.timeZone = TimeZone(identifier: "Asia/Tokyo")
         
            
            realmTrip.startDate = startDatePicker.date
            realmTrip.endDate = endDatePicker.date
            
    print(realmTrip.startDate)
    print(realmTrip.endDate)
        
            realmTrip.image = tripImage.image?.jpegData(compressionQuality: 1.0)
            
  
            //id
            RealmTripList = realm.objects(RealmTrip.self)
            
              generateDates(between: realmTrip.startDate, and: realmTrip.endDate, byAdding:.day)
            realmTrip.dateList = dateList
            if RealmTripList.count != 0 {
                realmTrip.id = RealmTripList.max(ofProperty: "id")! + 1
            }
            
            try! realm.write{
                realm.add(realmTrip)
                
                print(realmTrip.dateList)
                
            }
            self.dismiss(animated: true, completion: nil)
            
        }
            
       
        
        
        
        
        
    }
    
    //キャンセル
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           titleTextField.resignFirstResponder()
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

/// UIImage拡張(データ)
public extension UIImage {
    
    // MARK: Public Methods
    
    
        func compressedJpegData(toKB:Int) -> Data? {
            let toKB = 16
            guard let resized = self.resized(withPercentage: 0.75) else { return nil }
            guard var data = resized.jpegData(compressionQuality: 0.9) else { return nil }

            let byte = [UInt8](data)
            if (byte.count / 1048576) >= toKB {
                // toKBを超えてた時
                guard let againImage = UIImage(data: data) else { return nil }
                guard let rescalingData = againImage.compressedJpegData(toKB: toKB) else { return nil }
                data = rescalingData
            }
            return data
        }

        func resized(withPercentage percentage: CGFloat) -> UIImage? {
            let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
            return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
                _ in draw(in: CGRect(origin: .zero, size: canvas))
            }
        }
   
    
    /// イメージ→PNGデータに変換する
    ///
    /// - Returns: 変換後のPNGデータ
    public func toPNGData() -> Data {
        
        guard let data = self.pngData() else {
            print("イメージをPNGデータに変換できませんでした。")
            return Data()
        }
        
        return data
    }
    
    /// イメージ→JPEGデータに変換する
    ///
    /// - Returns: 変換後のJPEGデータ
    public func toJPEGData() -> Data {
        
        guard let data = self.jpegData(compressionQuality: 1.0) else {
            print("イメージをJPEGデータに変換できませんでした。")
            return Data()
        }
        
        return data
    }
    
}
