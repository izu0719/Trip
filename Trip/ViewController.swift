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
        
        // レイアウト
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        
        do{
            let realm = try! Realm()
            RealmTripList = realm.objects(RealmTrip.self)
            collectionView.reloadData()
            
        }catch{
            
        }
        
    }
    
    
    
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return RealmTripList.count
    }
    
    //セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先程命名した"Cell")
        cell.backgroundColor = UIColor.red  // セルの色
        
        if let cell = cell as? CollectionViewCell {
            
            cell.titleLabel.text = RealmTripList[indexPath.row].title
            cell.dateLabel.text = RealmTripList[indexPath.row].startDate + "〜" + RealmTripList[indexPath.row].endDate
            
        }
        
        return cell
    }
    
    
    
    
    //レイアウト
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 2 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        collectionView.reloadData()
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Schedule", sender: RealmTripList[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "Schedule" {
            // ③遷移先ViewCntrollerの取得
            let nextView = segue.destination as! AddTripViewController

            let realm = try! Realm()
            let realmTrip = RealmTrip()
            var scheduleList = List<Schedule>()

            RealmTripList = realm.objects(RealmTrip.self)
            if RealmTripList.count != 0 {
                realmTrip.id = RealmTripList.max(ofProperty: "id")! + 1
            }
            //  AddTripViewController.realmTrip = realmTrip

        }  else if segue.identifier == "Schedule" {
            let scheduleViewController: ScheduleViewController = segue.destination as! ScheduleViewController

     
           var idRealmTrip = try! Realm().objects(RealmTrip.self).filter("id == %@", RealmTrip().id).last
            
            
//            var idList = idRealmTrip?.scheduleList
//
            scheduleViewController.idList = idRealmTrip!.scheduleList
            
            print(scheduleViewController.idList)
        }

        
    }
    
 
    
}





