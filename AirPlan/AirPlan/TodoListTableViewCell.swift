//
//  TodoListTableViewCell.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/18.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell, UIEssentials {
    let weatherImage = UIImageView()
    let categoryLabel = UILabel()
    let contentsLabel = UILabel()
    let checkButton = UIButton()
    
    func initialSetup() {
        [weatherImage, categoryLabel, contentsLabel, checkButton].forEach { self.addSubview($0) }
        self.layer.borderWidth = 3
        categoryLabel.textAlignment = .left
        contentsLabel.textAlignment = .left
    }
    
    func makeUI() {
        weatherImage.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(weatherImage.snp.trailing).offset(10)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.leading.equalTo(weatherImage.snp.trailing).offset(10)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(10)
            $0.leading.equalTo(contentsLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(self.snp.trailing).offset(-10)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
