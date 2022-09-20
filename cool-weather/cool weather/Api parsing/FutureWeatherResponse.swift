//
//  FutureWeatherResponse.swift
//  cool weather
//
//  Created by Matthew on 26.06.22.
//

import Foundation

struct WeatherFutureResponse: Decodable {
    
    let forecast: (Forecast)
}

struct Forecast: Decodable {
    
    let forecastday: [Forecastday]

}

struct Forecastday: Decodable {
    
    let date: String
    let day: Day
}


struct Day: Decodable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let daily_chance_of_rain: Int
    let maxwind_kph: Double
    let avghumidity: Double
    let condition: Conditions
    
}

struct Conditions: Decodable {
    
    let text: String
    let icon: String
    
}
