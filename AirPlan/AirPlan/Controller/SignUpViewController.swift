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
        signUpView.idDuplicateCheckButton.addTarget(self, action: #selector(idDuplicateCheckButtonClicked(_:)), for: .touchUpInside)
        signUpView.nicknameDuplicateCheckButton.addTarget(self, action: #selector(nicknameDuplicateCheckButtonClicked(_:)), for: .touchUpInside)
        signUpView.idTextField.addTarget(self, action: #selector(didIDTextFieldChange), for: .editingChanged)
        signUpView.nicknameTextField.addTarget(self, action: #selector(didNicknameTextFieldChange), for: .editingChanged)
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
    
    @objc func idDuplicateCheckButtonClicked(_ sender: UIButton) {
        let email = self.signUpView.idTextField.text!
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        self.signUpView.errorMSG(msg: "")
        
        if email == "" {
            self.signUpView.errorMSG(msg: Constants.EMPTYEMAIL)
            return
        }
        
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) != true {
            self.signUpView.errorMSG(msg: Constants.WRONGEMAIL)
            return
        }
        
        let userDB = FireStoreData.shared.UserData()
        let query = userDB.whereField("email", isEqualTo: email)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
                self.signUpView.idDuplicateCheckButton.backgroundColor = .lightGray
                self.signUpView.errorMSG(msg: "")
            } else {
                //중복 체크 미통과
                self.signUpView.idDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
                self.signUpView.errorMSG(msg: Constants.DUPLICATEEMAIL)
            }
        }
    }
    
    @objc func nicknameDuplicateCheckButtonClicked(_ sender: UIButton) {
        let nickname = self.signUpView.nicknameTextField.text!
        let nicknameRegex = "^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,8}$"
        
        self.signUpView.errorMSG(msg: "")
        
        if nickname == "" {
            self.signUpView.errorMSG(msg: Constants.EMPTYNICKNAME)
            return
        }
        
        if NSPredicate(format: "SELF MATCHES %@", nicknameRegex).evaluate(with: nickname) != true {
            self.signUpView.errorMSG(msg: Constants.WRONGNICKNAME)
            return
        }
        
        let userDB = FireStoreData.shared.UserData()
        let query = userDB.whereField("nickname", isEqualTo: nickname)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
                self.signUpView.nicknameDuplicateCheckButton.backgroundColor = .lightGray
                self.signUpView.errorMSG(msg: "")
            } else {
                //중복 체크 미통과
                self.signUpView.nicknameDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
                self.signUpView.errorMSG(msg: Constants.DUPLICATENICKNAME)
            }
        }
    }
    
    @objc func didIDTextFieldChange() {
        self.signUpView.idDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
        
    }
    
    @objc func didNicknameTextFieldChange() {
        self.signUpView.nicknameDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
    }
}
