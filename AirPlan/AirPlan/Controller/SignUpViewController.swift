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
    var checkList = [Constants.PASSEMAIL: false, Constants.PASSPASSWORD: false, Constants.PASSNICKNAME: false]
    
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
        signUpView.passwordCheckTextField.addTarget(self, action: #selector(didPasswordCheckTextFieldChange), for: .editingDidEnd)
    }
    
    @objc func signUpButtonClicked() {
        let email = self.signUpView.idTextField.text!
        let password = self.signUpView.passwordTextField.text!
        let nickname = self.signUpView.nicknameTextField.text!
        var unconfirmedList = [Constants.PASSEMAIL, Constants.PASSPASSWORD, Constants.PASSNICKNAME]
        
        var required = checkList.filter { $0.value == true }
        
        required.keys.forEach {
            guard let index = unconfirmedList.firstIndex(of: $0) else { return }
            unconfirmedList.remove(at: index)
        }
        
        if !unconfirmedList.isEmpty {
            switch unconfirmedList.first {
            case Constants.PASSEMAIL :
                self.signUpView.idTextField.becomeFirstResponder()
                return
            case Constants.PASSPASSWORD :
                self.signUpView.passwordTextField.becomeFirstResponder()
                return
            case Constants.PASSNICKNAME :
                self.signUpView.nicknameTextField.becomeFirstResponder()
                return
            default:
                break
            }
        }
        
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
        
        if email.isEmpty {
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
                self.signUpView.errorMSG(msg: Constants.PASSEMAIL)
                self.checkList.updateValue(true, forKey: Constants.PASSEMAIL)
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
        
        if nickname.isEmpty {
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
                self.signUpView.errorMSG(msg: Constants.PASSNICKNAME)
                self.checkList.updateValue(true, forKey: Constants.PASSNICKNAME)
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
    
    @objc func didPasswordCheckTextFieldChange() {
        let password = self.signUpView.passwordTextField.text
        let passwordCheck = self.signUpView.passwordCheckTextField.text
        
        self.signUpView.errorMSG(msg: password == passwordCheck ? Constants.PASSPASSWORD : Constants.CONFIRMPASSWORD)
        self.checkList.updateValue(password == passwordCheck ? true : false, forKey: Constants.PASSPASSWORD)
    }
}
