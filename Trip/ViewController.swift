//
//  ViewController.swift
//  Trip
//
//  Created by 坂本 泉 on 2020/02/27.
//  Copyright © 2020 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var RealmTripList: Results<RealmTrip>!
    
    @IBOutlet var collectionView: UICollectionView!
    
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        collectionView.layer.cornerRadius = 25
        
        // レイアウト
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        
        do{
            let realm = try! Realm()
            RealmTripList = realm.objects(RealmTrip.self)
            collectionView.reloadData()
            
        }
        
    }
    
    
    
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return RealmTripList.count
    }
    
    //セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // 表示するセルを登録
       
        if let cell = cell as? CollectionViewCell {
            
            cell.titleLabel.text = RealmTripList[indexPath.row].title
            
            let format = DateFormatter()
                      format.dateFormat = "yyyy/MM/dd"
            
            let startDateText = format.string(from: RealmTripList[indexPath.row].startDate)
            let endDateText = format.string(from: RealmTripList[indexPath.row].endDate)
            cell.dateLabel.text = startDateText + "〜" + endDateText
            
            let uiimage = UIImage(data: RealmTripList[indexPath.row].image!)!
            
            cell.backgroundImageView.image = uiimage
            cell.backgroundImageView.contentMode = .scaleAspectFill
            
            cell.titleLabel.textColor = UIColor.white
            cell.dateLabel.textColor = UIColor.white
            
        }
        
        return cell
    }
    
    
    
    
    //レイアウト
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 30
        
        let cellSize : CGFloat = self.view.bounds.width - horizontalSpace
        return CGSize(width: cellSize, height: cellSize / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 15
          
      }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        collectionView.reloadData()
        
    }
    
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "Schedule", sender: RealmTripList[indexPath.row])
//
//        //    var idRealmTrip = RealmTripList[indexPath.row]
//        //      scheduleViewController.idList = idRealmTrip.scheduleList
//        //
//        //        print(scheduleViewController.idList)
//
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Container", sender: RealmTripList[indexPath.row])

        //    var idRealmTrip = RealmTripList[indexPath.row]
        //      scheduleViewController.idList = idRealmTrip.scheduleList
        //
        //        print(scheduleViewController.idList)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        if segue.identifier == "Schedule" {
//            let scheduleViewController: ScheduleViewController = segue.destination as! ScheduleViewController
//
//            let idRealmTrip = sender as! RealmTrip
//
//            scheduleViewController.idRealmTrip = idRealmTrip
//            scheduleViewController.idList = idRealmTrip.scheduleList
//
//        }else
        if segue.identifier ==  "Container"{
             let containerViewController: ContainerViewController = segue.destination as! ContainerViewController
                       
            let idRealmTrip = sender as! RealmTrip

            containerViewController.idRealmTrip = idRealmTrip
            containerViewController.idList = idRealmTrip.scheduleList
                       
                      
        }


    }

  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//          if segue.identifier == "Schedule" {
//              let scheduleViewController: ScheduleViewController = segue.destination as! ScheduleViewController
//
//          //  let tripId = sender as! Int
//                //as Int
//
//
//        //    scheduleViewController.tripId = tripId
//            print(tripId)
//       //     scheduleViewController.idList = RealmTripList?[tripId].scheduleList
//
//          }
          
          
      }
      
    






