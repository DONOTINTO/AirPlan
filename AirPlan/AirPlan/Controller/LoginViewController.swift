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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.initialSetup()
        loginView.makeUI()
        loginView.refresh()
        self.addButtonsAction()
    }
    
    func addButtonsAction() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        loginView.signInGoogleButton.addTarget(self, action: #selector(signInGoogleButtonClicked), for: .touchUpInside)
        loginView.testLogOutButton.addTarget(self, action: #selector(testLogOutButtonClicked), for: .touchUpInside)
    }
    
    // 일반 이메일 - 로그인 버튼 클릭 시
    @objc func loginButtonClicked() {
        let email = self.loginView.idTextField.text!
        let password = self.loginView.passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            self?.loginView.makeLogout(status: .login)
        }
    }
    
    // 일반 이메일 - 회원가입 버튼 클릭 시
    @objc func signUpButtonClicked() {
        let email = self.loginView.idTextField.text!
        let password = self.loginView.passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("SignUp Success")
        }
    }
    
    // 구글 - 구글 로그인/회원가입 버튼 클릭 시
    @objc func signInGoogleButtonClicked() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                self.loginView.testLabel.text = result?.user.email
                self.loginView.makeLogout(status: .login)
            }
        }
    }
    
    // 로그아웃
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
