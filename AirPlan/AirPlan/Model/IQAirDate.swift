//
//  IQAirDate.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/07/16.
//

import Foundation

// 날짜와 관련된 기능 모음
class IQAirDate {
    static var shared = IQAirDate()
    
    private let date = Date()
    private let dateFomatter = DateFormatter()
    
    private init() { }
    
    private func setTimeFormatter() {
        IQAirDate.shared.dateFomatter.timeStyle = .none
        IQAirDate.shared.dateFomatter.locale = Locale(identifier: "ko-KR")
        IQAirDate.shared.dateFomatter.dateFormat = "오늘\n MMM d일 (E)"
    }
    
    func fetchDate() -> String {
        setTimeFormatter()
        return IQAirDate.shared.dateFomatter.string(from: date)
    }
}
