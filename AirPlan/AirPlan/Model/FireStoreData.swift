//
//  FireStoreData.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/08/06.
//

import UIKit
import FirebaseFirestore

class FireStoreData {
    static let shared = FireStoreData()
    
    private init() {}
    
    func UserData() -> CollectionReference {
        let db = Firestore.firestore()
        return db.collection("USER")
    }
    
    func dataBase() -> Firestore {
        return Firestore.firestore()
    }
}
