//
//  SignUpView.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/08/01.
//

import UIKit
import SnapKit

class SignUpView: UIView, UIEssentials {
    let logoImageView = UIImageView()
    let infoLabel = UILabel()
    let idTextField = UITextField()
    let idDuplicateCheckButton = UIButton()
    let passwordTextField = UITextField()
    let passwordCheckTextField = UITextField()
    let nicknameLabel = UILabel()
    let nicknameTextField = UITextField()
    let nicknameDuplicateCheckTextField = UITextField()
    let signUpButton = UIButton()
    
    func initialSetup() {
        [logoImageView, infoLabel, idTextField, idDuplicateCheckButton, passwordTextField, passwordCheckTextField, nicknameLabel, nicknameTextField, nicknameDuplicateCheckTextField, signUpButton].forEach {
            self.addSubview($0)
        }
        
        self.inputViewController?.navigationItem.titleView = logoImageView
        self.backgroundColor = .white
        logoImageView.image = UIImage(named: "Logo-Image")
        infoLabel.text = "가입 정보 입력"
        
        idTextField.placeholder = "아이디를 입력하세요."
        idTextField.addLeftPadding()
        idTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        idTextField.layer.borderWidth = 1
        
        passwordTextField.placeholder = "비밀번호를 입력하세요."
        passwordTextField.addLeftPadding()
        passwordTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        passwordTextField.layer.borderWidth = 1
        
        passwordCheckTextField.placeholder = "비밀번호 확인"
        passwordCheckTextField.addLeftPadding()
        passwordCheckTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        passwordCheckTextField.layer.borderWidth = 1
        
        nicknameLabel.text = "닉네임"
        
        nicknameTextField.placeholder = "닉네임을 입력하세요."
        nicknameTextField.addLeftPadding()
        nicknameTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        nicknameTextField.layer.borderWidth = 1
    }
    
    func makeUI() {
        infoLabel.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.top.equalTo(infoLabel.safeAreaLayoutGuide.snp.bottom).offset(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.top.equalTo(idTextField.safeAreaLayoutGuide.snp.bottom).offset(10)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.top.equalTo(passwordTextField.safeAreaLayoutGuide.snp.bottom)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.top.equalTo(passwordCheckTextField.safeAreaLayoutGuide.snp.bottom).offset(30)
        }
    }
}
