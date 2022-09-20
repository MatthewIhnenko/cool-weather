//
//  astroWeatherResponse.swift
//  cool weather
//
//  Created by Matthew on 28.06.22.
//

import Foundation

struct AstroWeatherResponse: Decodable {
    
    let astronomy: (Astro)
}
struct Astro: Decodable {
    
    let astro: (Moonphase)
    
}

struct Moonphase: Decodable {
    
    let sunrise: String
    let sunset: String
    
    
}
