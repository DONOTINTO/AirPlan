//
//  SignUpViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/08/01.
//

import UIKit

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
    }
}
