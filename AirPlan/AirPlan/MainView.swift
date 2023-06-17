//
//  MainView.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/16.
//

import UIKit

class MainView: UIView, UIEssentials {
    let profileView = ProfileView()
    let infoView = InfoView()
    let todayTDView = TodayTDView()
    let tomorrowTDView = TomorrowTDView()
    
    func initialSetup() {
        [profileView, infoView, todayTDView, tomorrowTDView].forEach { self.addSubview($0) }
    }
    
    func makeUI() {
        profileView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(20)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        todayTDView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(20)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}

extension MainView {
    class ProfileView: UIView, UIEssentials {
        let profileImage: UIImageView = UIImageView()
        let userIDLabel: UILabel = UILabel()
        let locationInfoLabel: UILabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialSetup()
            makeUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func initialSetup() {
            self.backgroundColor = .darkGray
            [profileImage, userIDLabel, locationInfoLabel].forEach { self.addSubview($0) }
            
            profileImage.backgroundColor = .brown
            profileImage.layer.cornerRadius = 50
            profileImage.layer.masksToBounds = true
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
    
    class InfoView: UIView, UIEssentials {
        let weatherImage = UIImageView()
        let airConditionImage = UIImageView()
        let weatherLabel = UILabel()
        let aqiLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialSetup()
            makeUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func initialSetup() {
            [weatherImage, airConditionImage, weatherLabel, aqiLabel].forEach { self.addSubview($0) }
            self.layer.borderWidth = 3
            weatherImage.backgroundColor = .black
            airConditionImage.backgroundColor = .black
            weatherLabel.text = "현재 기온"
            aqiLabel.text = "현재 AQI"
        }
        
        func makeUI() {
            weatherImage.snp.makeConstraints {
                $0.width.height.equalTo(120)
                $0.top.equalTo(self.snp.top).offset(10)
                $0.leading.equalTo(self.snp.leading).offset(30)
            }
            
            airConditionImage.snp.makeConstraints {
                $0.width.height.equalTo(120)
                $0.top.equalTo(self.snp.top).offset(10)
                $0.trailing.equalTo(self.snp.trailing).offset(-30)
            }
            
            weatherLabel.snp.makeConstraints {
                $0.centerX.equalTo(weatherImage.snp.centerX)
                $0.top.equalTo(weatherImage.snp.bottom).offset(10)
                $0.bottom.equalTo(self.snp.bottom).offset(-10)
            }
            
            aqiLabel.snp.makeConstraints {
                $0.centerX.equalTo(airConditionImage.snp.centerX)
                $0.top.equalTo(airConditionImage.snp.bottom).offset(10)
                $0.bottom.equalTo(self.snp.bottom).offset(-10)
            }
        }
    }
    
    class TodayTDView: UIView, UIEssentials, UITableViewDelegate, UITableViewDataSource {
        let todayLabel = UILabel()
        let todoTableView = UITableView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialSetup()
            makeUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func initialSetup() {
            [todayLabel, todoTableView].forEach { self.addSubview($0) }
            todoTableView.delegate = self
            todoTableView.dataSource = self
            
            todayLabel.textAlignment = .center
            todayLabel.numberOfLines = 2
            todayLabel.text = "오늘 \n 0월 00일 (토)"
        }
        
        func makeUI() {
            todayLabel.snp.makeConstraints {
                $0.top.equalTo(self.snp.top).offset(10)
                $0.leading.equalTo(self.snp.leading).offset(10)
            }
            
            todoTableView.snp.makeConstraints {
                $0.top.equalTo(todayLabel.snp.bottom).offset(10)
                $0.leading.equalTo(self.snp.leading).offset(10)
                $0.trailing.equalTo(self.snp.trailing).offset(-10)
                $0.bottom.equalTo(self.snp.bottom).offset(-10)
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
    
    class TomorrowTDView: UIView, UIEssentials {
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialSetup()
            makeUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func initialSetup() {
        }
        
        func makeUI() {
        }
    }
}
