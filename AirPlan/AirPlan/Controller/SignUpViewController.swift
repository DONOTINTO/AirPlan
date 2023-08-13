//
//  SignUpViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/08/01.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    let signUpView = SignUpView()
    var checkList = (email : false, nickName : false)
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoImageView = UIImageView(image: UIImage(named: "Logo-Image"))
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
        
        signUpView.initialSetup()
        signUpView.makeUI()
        
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signUpView.idDuplicateCheckButton.addTarget(self, action: #selector(DuplicateCheckButtonClicked), for: .touchUpInside)
    }
    
    @objc func signUpButtonClicked() {
        let email = self.signUpView.idTextField.text!
        let password = self.signUpView.passwordTextField.text!
        let nickname = self.signUpView.nicknameTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let UID = authResult?.user.uid else { return }
            let db = FireStoreData.shared.dataBase()
            db.collection("USER").document(UID).setData(["email" : email, "password" : password, "nickname" : nickname])
            
            print("SignUp Success")
        }
    }
    
    @objc func DuplicateCheckButtonClicked() {
        let email = self.signUpView.idTextField.text!
        let userDB = FireStoreData.shared.UserData()
        
        let query = userDB.whereField("email", isEqualTo: email)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                self.checkList.email = true
            } else {
                self.checkList.email = false
            }
        }
    }
}
