//
//  LoginViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/07/10.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.initialSetup()
        loginView.makeUI()
    }
}
