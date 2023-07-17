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
    
    private func setTodayTimeFormatter() {
        IQAirDate.shared.dateFomatter.timeStyle = .none
        IQAirDate.shared.dateFomatter.locale = Locale(identifier: "ko-KR")
        IQAirDate.shared.dateFomatter.dateFormat = "오늘\n MMM d일 (E)"
    }
    
    private func getTomorrowDate() -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: 1, to: IQAirDate.shared.date) else { return Date() }
        return date
    }
    
    func fetchDate() -> String {
        setTodayTimeFormatter()
        return IQAirDate.shared.dateFomatter.string(from: date)
    }
    
    func fetchTomorrowDate() -> String {
        self.setTodayTimeFormatter()
        IQAirDate.shared.dateFomatter.dateFormat = "내일\n MMM d일 (E)"
        let date = self.getTomorrowDate()
        return IQAirDate.shared.dateFomatter.string(from: date)
    }
}
