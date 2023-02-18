//
//  WeatherModel.swift
//  _7. Clima-SUI
//
//  Created by Андрей Бородкин on 18.02.2023.
//

import Foundation

struct WeatherModel {
    
    var conditionID: Int
    var cityName: String
    var temperature: Double
    
    var temperatureString: String {
        String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        
        switch conditionID {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 700...781: return "tornado"
        case 800      : return "sun.max"
        case 801...804: return "cloud"
        default:        return "aqi.high"
        }
        
    }
    
   
}
