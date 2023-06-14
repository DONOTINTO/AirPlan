//
//  MainView.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/12.
//

import UIKit
import SnapKit

class MainProfileView: UIView, UIEssentials {
    let profileImage: UIImageView = UIImageView()
    let userIDLabel: UILabel = UILabel()
    let locationInfoLabel: UILabel = UILabel()
    
    func initialSetup() {
        self.backgroundColor = .darkGray
        [profileImage, userIDLabel, locationInfoLabel].forEach { self.addSubview($0) }
        
        profileImage.backgroundColor = .brown
        userIDLabel.text = "테스트"
        locationInfoLabel.text = "00구 \n 00시, 대한민국"
        locationInfoLabel.textAlignment = .center
        locationInfoLabel.numberOfLines = 2
    }
    
    func makeUI() {
        profileImage.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(self.snp.leading).offset(10)
        }
        
        userIDLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.centerX.equalTo(profileImage.snp.centerX)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
        
        locationInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.leading.equalTo(profileImage.snp.trailing).offset(30)
            $0.trailing.equalTo(self.snp.trailing).offset(-30)
        }
    }
}
