//
//  SignUpViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/08/01.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

let DUPLICATEID = "duplicateID"
let CONFIRMPASSWORD = "confirmPassword"
let DUPLICATENICKNAME = "duplicateNickname"

class SignUpViewController: UIViewController {
    let signUpView = SignUpView()
    var checkList = [DUPLICATEID: false, CONFIRMPASSWORD: false, DUPLICATENICKNAME: false]
    
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
        // 1. 정규식대로 썼는가
            // 1-1. 정규식 대로 썻을 때
            // 2번으로 넘어감
            // 1-2. 정규식 대로 안썻을 때
            // 안내 문구(이메일을 정확히 입력해주세요)
        // 2. 중복값이 있는가
            // 2-1. 중복값이 없을 때
            // 체크 버튼이 비활성화, 체크 확인
            // 2-2. 중복값이 있을 때
            // 안내 문구(생성된 아이디가 존재합니다.)
        
        let email = self.signUpView.idTextField.text!
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) != true {
            print("이메일을 정확히 입력해주세요")
            return
        }
        
        let userDB = FireStoreData.shared.UserData()
        let query = userDB.whereField("email", isEqualTo: email)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
                self.checkList.updateValue(true, forKey: DUPLICATEID)
                self.signUpView.nicknameDuplicateCheckButton.backgroundColor = .lightGray
            } else {
                //중복 체크 미통과
                self.signUpView.nicknameDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
                print("생성된 이메일이 존재합니다")
            }
        }
    }
    
    @objc func nicknameDuplicateCheckButtonClicked(_ sender: UIButton) {
        let nickname = self.signUpView.nicknameTextField.text!
        let nicknameRegex = "^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,8}$"
        
        if nickname == "" {
            print("닉네임을 입력해주세요.")
            return
        }
        
        if NSPredicate(format: "SELF MATCHES %@", nicknameRegex).evaluate(with: nickname) != true {
            print("띄어쓰기 없이 한글,영문(숫자포함) 2~8자까지 사용 가능합니다 ")
            return
        }
        
        let userDB = FireStoreData.shared.UserData()
        let query = userDB.whereField("nickname", isEqualTo: nickname)
        query.getDocuments { document, error in
            if document!.documents.isEmpty {
                //중복 체크 통과
                self.checkList.updateValue(true, forKey: DUPLICATENICKNAME)
                self.signUpView.nicknameDuplicateCheckButton.backgroundColor = .lightGray
            } else {
                //중복 체크 미통과
                self.signUpView.nicknameDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
                print("중복된 닉네임입니다")
            }
        }
    }
    
    @objc func didIDTextFieldChange() {
        self.signUpView.idDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
        checkList.updateValue(false, forKey: DUPLICATEID)
    }
    
    @objc func didNicknameTextFieldChange() {
        self.signUpView.nicknameDuplicateCheckButton.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1)
        checkList.updateValue(false, forKey: DUPLICATENICKNAME)
    }
}
