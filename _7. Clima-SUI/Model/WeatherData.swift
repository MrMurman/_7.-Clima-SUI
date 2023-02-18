//
//  WeatherData.swift
//  _7. Clima-SUI
//
//  Created by Андрей Бородкин on 18.02.2023.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    
    let weather: [Weather]
    
    let main: Main
    
}


struct Main: Decodable {
    
    let temp: Double
}

struct Weather: Decodable {
    
    let id: Int 
}
