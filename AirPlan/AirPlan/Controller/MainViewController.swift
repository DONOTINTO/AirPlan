//
//  ViewController.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/12.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
        mainView.initialSetup()
        mainView.makeUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

