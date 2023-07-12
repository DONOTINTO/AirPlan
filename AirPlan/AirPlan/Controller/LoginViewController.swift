//
//  LoginViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/07/10.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let actionCodeSettings = ActionCodeSettings()
    
    override func loadView() {
        self.view = loginView
        loginView.initialSetup()
        loginView.makeUI()
        loginView.refresh()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        loginView.signInGoogleButton.addTarget(self, action: #selector(signInGoogleButtonClicked), for: .touchUpInside)
        loginView.testLogOutButton.addTarget(self, action: #selector(testLogOutButtonClicked), for: .touchUpInside)
    }
    
    @objc func loginButtonClicked() {
        let email = self.loginView.idTextField.text!
        let password = self.loginView.passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            guard error == nil else {
                print(error!.localizedDescription)
                print("로그인 실패")
                return
            }
            print("로그인 성공")
            self?.loginView.makeLogout(status: .login)
        }
    }
    
    @objc func signUpButtonClicked() {
        let email = self.loginView.idTextField.text!
        let password = self.loginView.passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                print(error!.localizedDescription)
                print("아이디 생성 실패")
                return
            }
            print("아이디 생성 완료")
        }
    }
    
    @objc func signInGoogleButtonClicked() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print("error")
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                print("저기")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                print("성공")
                self.loginView.testLabel.text = result?.user.email
                self.loginView.makeLogout(status: .login)
            }
        }
    }
    
    @objc func testLogOutButtonClicked() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.loginView.testLabel.text = "로그아웃!"
            self.loginView.makeLogout(status: .logout)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
