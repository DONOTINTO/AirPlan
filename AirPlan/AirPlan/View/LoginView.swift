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

enum LoginStatus {
    case login
    case logout
}

class LoginView: UIView, UIEssentials {
    let loginStackView = UIStackView()
    let idTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    var signInGoogleButton = GIDSignInButton()
    let testLogOutButton = UIButton()
    let logoImageView = UIImageView()
    let infoLabel = UILabel()
    var loginStatus = LoginStatus.logout
    
    func refresh() {
        switch loginStatus {
        case .login:
            testLogOutButton.isHidden = false
        case .logout:
            testLogOutButton.isHidden = true
        }
    }
    
    func makeLogout(status: LoginStatus) {
        loginStatus = status
        self.refresh()
    }
    
    func initialSetup() {
        [loginStackView, infoLabel, signUpButton, signInGoogleButton, testLogOutButton, logoImageView].forEach { self.addSubview($0) }
        [idTextField, passwordTextField, loginButton].forEach { loginStackView.addArrangedSubview($0)}
        
        self.backgroundColor = .white
        logoImageView.image = UIImage(named: "Logo-Image")
        
        loginStackView.axis = .vertical
        loginStackView.spacing = 0
        loginStackView.alignment = .fill
        loginStackView.distribution = .fillEqually
        
        idTextField.placeholder = "아이디"
        idTextField.backgroundColor = .white
        idTextField.addLeftPadding()
        idTextField.layer.cornerRadius = 5
        idTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.backgroundColor = .white
        passwordTextField.addLeftPadding()
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = UIColor(cgColor: CGColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1))
        loginButton.titleLabel?.textColor = .black
        loginButton.layer.cornerRadius = 5
        loginButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        infoLabel.text = "아직 회원이 아니신가요?"
        infoLabel.textColor = .black
        infoLabel.font = UIFont.systemFont(ofSize: 13)
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        signUpButton.layer.borderWidth = 1
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        
        testLogOutButton.setTitle("로그아웃", for: .normal)
        testLogOutButton.backgroundColor = .systemGreen
        testLogOutButton.titleLabel?.textColor = .black
        
        signInGoogleButton.colorScheme = .dark
        signInGoogleButton.style = .wide
    }
    
    func makeUI() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.top.equalTo(self.snp.top).offset(150)
        }
        
        loginStackView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(40)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-40)
            $0.top.equalTo(logoImageView.snp.bottom).offset(50)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(loginStackView.snp.bottom).offset(50)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.snp.leading).offset(40)
            $0.trailing.equalTo(self.snp.trailing).offset(-40)
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
        }
        
        signInGoogleButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(40)
            $0.trailing.equalTo(self.snp.trailing).offset(-40)
            $0.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
        
        testLogOutButton.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(40)
            $0.trailing.equalTo(self.snp.trailing).offset(-40)
            $0.top.equalTo(signInGoogleButton.snp.bottom).offset(10)
        }
    }
}
