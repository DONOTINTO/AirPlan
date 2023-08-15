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
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let logoImageView = UIImageView(image: UIImage(named: "Logo-Image"))
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
        
        signUpView.idTextField.delegate = self
        signUpView.passwordTextField.delegate = self
        signUpView.passwordCheckTextField.delegate = self
        signUpView.nicknameTextField.delegate = self
        
        signUpView.initialSetup()
        signUpView.makeUI()
        
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        signUpView.idDuplicateCheckButton.addTarget(self, action: #selector(idDuplicateCheckButtonClicked), for: .touchUpInside)
        signUpView.nicknameDuplicateCheckButton.addTarget(self, action: #selector(nicknameDuplicateCheckButtonClicked), for: .touchUpInside)
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
    
    @objc func idDuplicateCheckButtonClicked() {
        let email = self.signUpView.idTextField.text!
        let userDB = FireStoreData.shared.UserData()
        
        let query = userDB.whereField("email", isEqualTo: email)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
            } else {
                //중복 체크 미통과
            }
        }
    }
    
    @objc func nicknameDuplicateCheckButtonClicked() {
        let nickname = self.signUpView.nicknameTextField.text!
        let userDB = FireStoreData.shared.UserData()
        
        let query = userDB.whereField("nickname", isEqualTo: nickname)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
            } else {
                //중복 체크 미통과
            }
        }
    }
}
