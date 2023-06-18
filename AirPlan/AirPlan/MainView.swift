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
    let mainStackView = UIStackView()
    
    func initialSetup() {
        self.addSubview(mainStackView)
        [profileView, infoView, todayTDView, tomorrowTDView].forEach { mainStackView.addArrangedSubview($0) }
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
    }
    
    func makeUI() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges).inset(10)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.top)
        }
        
        infoView.snp.makeConstraints {
            $0.leading.lessThanOrEqualTo(mainStackView.snp.leading).offset(10)
            $0.trailing.greaterThanOrEqualTo(mainStackView.snp.trailing).offset(-10)
        }
        
        todayTDView.snp.makeConstraints {
            $0.height.equalTo(tomorrowTDView)
            $0.leading.lessThanOrEqualTo(mainStackView.snp.leading).offset(10)
            $0.trailing.greaterThanOrEqualTo(mainStackView.snp.trailing).offset(-10)
        }
        
        tomorrowTDView.snp.makeConstraints {
            $0.leading.lessThanOrEqualTo(mainStackView.snp.leading).offset(10)
            $0.trailing.greaterThanOrEqualTo(mainStackView.snp.trailing).offset(-10)
            $0.bottom.equalTo(mainStackView.snp.bottom)
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
            [profileImage, userIDLabel, locationInfoLabel].forEach { self.addSubview($0) }
            self.layer.borderWidth = 3
            profileImage.backgroundColor = .black
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
                $0.leading.equalTo(self.snp.leading).offset(30)
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
                $0.width.height.equalTo(80)
                $0.top.equalTo(self.snp.top).offset(10)
                $0.centerX.equalTo(self.snp.centerX).offset(-70)
            }
            
            airConditionImage.snp.makeConstraints {
                $0.width.height.equalTo(80)
                $0.top.equalTo(self.snp.top).offset(10)
                $0.centerX.equalTo(self.snp.centerX).offset(70)
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
            self.layer.borderWidth = 3
            todoTableView.delegate = self
            todoTableView.dataSource = self
            todayLabel.textAlignment = .center
            todayLabel.numberOfLines = 2
            todayLabel.text = "오늘 \n 0월 00일 (토)"
            todoTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else { return UITableViewCell() }
            cell.initialSetup()
            cell.makeUI()
            
            return cell
        }
    }
    
    class TomorrowTDView: UIView, UIEssentials, UITableViewDelegate, UITableViewDataSource {
        let tomorrowLabel = UILabel()
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
            [tomorrowLabel, todoTableView].forEach { self.addSubview($0) }
            self.layer.borderWidth = 3
            todoTableView.delegate = self
            todoTableView.dataSource = self
            tomorrowLabel.textAlignment = .center
            tomorrowLabel.numberOfLines = 2
            tomorrowLabel.text = "내일 \n 0월 00일 (일)"
            todoTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
        }
        
        func makeUI() {
            tomorrowLabel.snp.makeConstraints {
                $0.top.equalTo(self.snp.top).offset(10)
                $0.leading.equalTo(self.snp.leading).offset(10)
            }
            
            todoTableView.snp.makeConstraints {
                $0.top.equalTo(tomorrowLabel.snp.bottom).offset(10)
                $0.leading.equalTo(self.snp.leading).offset(10)
                $0.trailing.equalTo(self.snp.trailing).offset(-10)
                $0.bottom.equalTo(self.snp.bottom).offset(-10)
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier, for: indexPath) as? TodoListTableViewCell else { return UITableViewCell() }
            cell.initialSetup()
            cell.makeUI()
            
            return cell
        }
    }
}
