//
//  IQAir.swift
//  AirPlan
//
//  Created by 이중엽 on 2023/06/18.
//

import Foundation

struct IQAir: Decodable {
    var status: String
    var data: IQAirData
}

struct IQAirData: Decodable {
    var city: String
    var state: String
    var country: String
    var location: Location
    var current: Current
}

struct Location: Decodable {
    var type: String
    var coordinates: [Double]
}

struct Current: Decodable {
    var pollution: Pollution
    var weather: Weather
}

struct Pollution: Decodable {
    var ts: String
    var aqius: Int
    var mainus: String
    var aqicn: Int
    var maincn: String
}

struct Weather: Decodable {
    var ts: String
    var tp: Double
    var pr: Double
    var hu: Double
    var ws: Double
    var wd: Double
    var ic: String
}
