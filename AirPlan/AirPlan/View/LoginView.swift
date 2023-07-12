//
//  LoginView.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/07/10.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginView: UIView, UIEssentials {
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    var signInGoogleButton = GIDSignInButton()
    let testLabel = UILabel()
    let testLogOutButton = UIButton()
    
    func initialSetup() {
        [idTextField, passwordTextField, loginButton, signUpButton, signInGoogleButton, testLabel, testLogOutButton].forEach { self.addSubview($0)}
        idTextField.backgroundColor = .lightGray
        passwordTextField.backgroundColor = .lightGray
        loginButton.backgroundColor = .systemBlue
        signUpButton.backgroundColor = .systemGreen
        testLogOutButton.backgroundColor = .systemGreen
        loginButton.titleLabel?.textColor = .black
        signUpButton.titleLabel?.textColor = .black
        testLogOutButton.titleLabel?.textColor = .black
        testLabel.text = "123"
        testLabel.textColor = .black
        testLabel.numberOfLines = 2
        
        idTextField.placeholder = "아이디를 입력해주세요."
        passwordTextField.placeholder = "비밀번호를 입력해주세요"
        loginButton.setTitle("로그인", for: .normal)
        signUpButton.setTitle("회원가입", for: .normal)
        testLogOutButton.setTitle("로그아웃", for: .normal)
    }
    
    func makeUI() {
        testLabel.snp.makeConstraints{
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(200)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
        }
        
        signInGoogleButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
        
        testLogOutButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.top.equalTo(signInGoogleButton.snp.bottom).offset(10)
        }
    }
}
