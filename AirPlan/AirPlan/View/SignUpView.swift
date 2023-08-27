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
    let idErrorLabel = UILabel()
    let idDuplicateCheckButton = UIButton()
    let passwordTextField = UITextField()
    let passwordCheckTextField = UITextField()
    let passwordErrorLabel = UILabel()
    let nicknameLabel = UILabel()
    let nicknameTextField = UITextField()
    let nicknameErrorLabel = UILabel()
    let nicknameDuplicateCheckButton = UIButton()
    let signUpButton = UIButton()
    
    func initialSetup() {
        [logoImageView, infoLabel, idTextField, idDuplicateCheckButton, passwordTextField, passwordCheckTextField, nicknameLabel, nicknameTextField, nicknameDuplicateCheckButton, signUpButton].forEach {
            self.addSubview($0)
        }
        
        [idErrorLabel, passwordErrorLabel, nicknameErrorLabel].forEach {
            self.addSubview($0)
        }
        
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
        
        idErrorLabel.font = .boldSystemFont(ofSize: 12)
        idErrorLabel.textColor = .lightGray
        
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
        
        passwordErrorLabel.font = .boldSystemFont(ofSize: 12)
        passwordErrorLabel.textColor = .lightGray
        
        nicknameLabel.text = "닉네임"
        
        nicknameTextField.placeholder = "닉네임을 입력하세요."
        nicknameTextField.addLeftPadding()
        nicknameTextField.layer.borderColor = CGColor(red: 216/255, green: 219/255, blue: 227/255, alpha: 1)
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.cornerRadius = 3
        
        nicknameErrorLabel.font = .boldSystemFont(ofSize: 12)
        nicknameErrorLabel.textColor = .lightGray
        
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
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
        }
        
        passwordCheckTextField.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            $0.top.equalTo(passwordTextField.snp.bottom)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(30)
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
    
    func errorMSG(msg: String) {
        switch msg {
        case Constants.WRONGEMAIL, Constants.DUPLICATEEMAIL, Constants.EMPTYEMAIL:
            self.addSubview(idErrorLabel)
            idErrorLabel.text = msg
            
            idErrorLabel.snp.makeConstraints {
                $0.top.equalTo(idTextField.snp.bottom)
                $0.trailing.equalTo(idTextField.snp.trailing)
            }
            
            passwordTextField.snp.remakeConstraints {
                $0.height.equalTo(50)
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
                $0.top.equalTo(idErrorLabel.snp.bottom).offset(10)
            }
            break
        case Constants.CONFIRMPASSWORD:
            self.addSubview(passwordErrorLabel)
            passwordErrorLabel.text = msg
            
            passwordErrorLabel.snp.makeConstraints {
                $0.top.equalTo(passwordCheckTextField.snp.bottom)
                $0.trailing.equalTo(passwordCheckTextField.snp.trailing)
            }
            
            nicknameLabel.snp.remakeConstraints {
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.top.equalTo(passwordErrorLabel.snp.bottom).offset(30)
            }
            break
            
        case Constants.DUPLICATENICKNAME, Constants.EMPTYNICKNAME, Constants.WRONGNICKNAME:
            self.addSubview(nicknameErrorLabel)
            nicknameErrorLabel.text = msg
            
            nicknameErrorLabel.snp.makeConstraints {
                $0.top.equalTo(nicknameTextField.snp.bottom)
                $0.trailing.equalTo(nicknameTextField.snp.trailing)
            }
            
            signUpButton.snp.remakeConstraints {
                $0.height.equalTo(50)
                $0.top.equalTo(nicknameErrorLabel.snp.bottom).offset(30)
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            }
            break
        default:
            idErrorLabel.snp.removeConstraints()
            passwordErrorLabel.snp.removeConstraints()
            nicknameErrorLabel.snp.removeConstraints()
            self.idErrorLabel.removeFromSuperview()
            self.passwordErrorLabel.removeFromSuperview()
            self.nicknameErrorLabel.removeFromSuperview()
            
            passwordTextField.snp.remakeConstraints {
                $0.height.equalTo(50)
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
                $0.top.equalTo(idTextField.snp.bottom).offset(10)
            }
            
            nicknameLabel.snp.remakeConstraints {
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(30)
            }
            
            signUpButton.snp.remakeConstraints {
                $0.height.equalTo(50)
                $0.top.equalTo(nicknameDuplicateCheckButton.snp.bottom).offset(30)
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-30)
            }
        }
    }
}
