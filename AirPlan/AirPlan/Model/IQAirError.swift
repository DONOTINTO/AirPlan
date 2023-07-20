//
//  IQAirError.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/07/20.
//

import Foundation

// 503 200 404 403 401
enum IQAirError: Error {
    /// 200
    case success
    /// 401
    case unauthorized
    /// 403
    case forbidden
    /// 404
    case notFound
    /// 503
    case serviceUnavailable
}

extension IQAirError {
    var localizedDescription: String {
        switch self {
        case .success: return "성공적으로 데이터를 가져왔습니다."
        case .unauthorized: return "접근 권한이 없습니다."
        case .forbidden: return "금지된 데이터입니다."
        case .notFound: return "데이터를 찾지 못하였습니다."
        case .serviceUnavailable: return "현재 서비스 이용이 불가합니다."
        }
    }
}
