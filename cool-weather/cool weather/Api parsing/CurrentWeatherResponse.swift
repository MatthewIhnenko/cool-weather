//
//  CurrentWeatherResponse.swift
//  cool weather
//
//  Created by Matthew on 23.06.22.
//

import Foundation

struct WeatherResponse: Decodable {
    
    let location: (Location)
    let current: (Current)
    
    
    
}
struct Location: Decodable {
    let name: String
    let country: String
}



struct Current: Decodable {
    let temp_c: Int
    let is_day: Int
    let condition: (Condition)
    let uv: Double
}

struct Condition: Decodable {
    let icon: String
}
