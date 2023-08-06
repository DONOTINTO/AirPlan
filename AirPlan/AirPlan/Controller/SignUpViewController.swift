//
//  SignUpViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/08/01.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    let signUpView = SignUpView()
    
    override func loadView() {
        self.view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoImageView = UIImageView(image: UIImage(named: "Logo-Image"))
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
        
        signUpView.initialSetup()
        signUpView.makeUI()
        
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
    
    @objc func signUpButtonClicked() {
        let email = self.signUpView.idTextField.text!
        let password = self.signUpView.passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("SignUp Success")
        }
    }
}
