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
    
    func isDuplicate(field: String, data: String, button: UIButton) {
        let userDB = FireStoreData.shared.UserData()
        let query = userDB.whereField(field, isEqualTo: data)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
                button.backgroundColor = .lightGray
            } else {
                //중복 체크 미통과
                button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
            }
        }
    }
}
