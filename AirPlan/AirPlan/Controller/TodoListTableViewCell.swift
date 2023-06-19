//
//  TodoListTableViewCell.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/18.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell, UIEssentials {
    static let identifier = "TodoListCell"
    let weatherImage = UIImageView()
    let categoryLabel = UILabel()
    let contentsLabel = UILabel()
    let checkButton = UIButton()
    
    func initialSetup() {
        [weatherImage, categoryLabel, contentsLabel, checkButton].forEach { self.addSubview($0) }
        self.backgroundColor = .white
        self.tintColor = .white
        weatherImage.backgroundColor = .black
        categoryLabel.textAlignment = .left
        categoryLabel.text = "카테고리명"
        categoryLabel.textColor = .black
        contentsLabel.textAlignment = .left
        contentsLabel.text = "내용"
        contentsLabel.textColor = .black
        checkButton.backgroundColor = .blue
    }
    
    func makeUI() {
        weatherImage.snp.makeConstraints {
            $0.height.equalTo(weatherImage.snp.width)
            $0.top.equalTo(self.snp.top).offset(3)
            $0.leading.equalTo(self.snp.leading).offset(3)
            $0.bottom.equalTo(self.snp.bottom).offset(-3)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(weatherImage.snp.trailing).offset(10)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.leading.equalTo(weatherImage.snp.trailing).offset(10)
            $0.bottom.equalTo(weatherImage.snp.bottom).offset(-10)
        }
        
        checkButton.snp.makeConstraints {
            $0.height.equalTo(checkButton.snp.width)
            $0.top.equalTo(self.snp.top).offset(30)
            $0.leading.equalTo(contentsLabel.snp.trailing).offset(30)
            $0.trailing.equalTo(self.snp.trailing).offset(-30)
            $0.bottom.equalTo(self.snp.bottom).offset(-30)
        }
    }
}
