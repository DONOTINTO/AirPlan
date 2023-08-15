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
    let nicknameDuplicateCheckButton = UIButton()
    let signUpButton = UIButton()
    
    func initialSetup() {
        [logoImageView, infoLabel, idTextField, idDuplicateCheckButton, passwordTextField, passwordCheckTextField, nicknameLabel, nicknameTextField, nicknameDuplicateCheckButton, signUpButton].forEach {
            self.addSubview($0)
        }
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        nicknameTextField.delegate = self
        
        self.inputViewController?.navigationItem.titleView = logoImageView
        self.backgroundColor = .white
        logoImageView.image = UIImage(named: "Logo-Image")
        infoLabel.text = "가입 정보 입력"
        infoLabel.font = .boldSystemFont(ofSize: 18)
        
        idTextField.placeholder = "아이디를 입력하세요."
        idTextField.addLeftPadding()
        idTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        idTextField.layer.borderWidth = 1
        idTextField.layer.cornerRadius = 5
        
        idDuplicateCheckButton.backgroundColor = UIColor(cgColor: CGColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1))
        idDuplicateCheckButton.setTitle("중복확인", for: .normal)
        idDuplicateCheckButton.setTitleColor(.white, for: .normal)
        idDuplicateCheckButton.layer.cornerRadius = 5
        
        passwordTextField.placeholder = "비밀번호를 입력하세요."
        passwordTextField.addLeftPadding()
        passwordTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        passwordCheckTextField.placeholder = "비밀번호 확인"
        passwordCheckTextField.addLeftPadding()
        passwordCheckTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        passwordCheckTextField.layer.borderWidth = 1
        passwordCheckTextField.layer.cornerRadius = 5
        passwordCheckTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        nicknameLabel.text = "닉네임"
        
        nicknameTextField.placeholder = "닉네임을 입력하세요."
        nicknameTextField.addLeftPadding()
        nicknameTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.cornerRadius = 3
        
        nicknameDuplicateCheckButton.backgroundColor = UIColor(cgColor: CGColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1))
        nicknameDuplicateCheckButton.setTitle("중복확인", for: .normal)
        nicknameDuplicateCheckButton.setTitleColor(.white, for: .normal)
        nicknameDuplicateCheckButton.layer.cornerRadius = 5
        
        signUpButton.backgroundColor = UIColor(cgColor: CGColor(red: 0/255, green: 168/255, blue: 168/255, alpha: 1))
        signUpButton.setTitle("회원가입 완료", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 5
    }
    
    func makeUI() {
        infoLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.top.equalTo(infoLabel.safeAreaLayoutGuide.snp.bottom).offset(40)
        }
        
        idDuplicateCheckButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(idTextField.snp.width).dividedBy(4)
            $0.centerY.equalTo(idTextField.snp.centerY)
            $0.trailing.equalTo(idTextField.snp.trailing).inset(10)
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
        
        nicknameTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.top.equalTo(nicknameLabel.safeAreaLayoutGuide.snp.bottom).offset(10)
        }
        
        nicknameDuplicateCheckButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(nicknameTextField.snp.width).dividedBy(4)
            $0.centerY.equalTo(nicknameTextField.snp.centerY)
            $0.trailing.equalTo(nicknameTextField.snp.trailing).inset(10)
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(nicknameDuplicateCheckButton.snp.bottom).offset(30)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
        }
    }
}
