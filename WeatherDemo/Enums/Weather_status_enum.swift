//
//  Weather_status_enum.swift
//  WeatherDemo
//
//  Created by Vlad on 31/8/25.
//

import Foundation

enum WeatherCondition: String {
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case snow = "Snow"
    case atmosphere = "Atmosphere"
    case clear = "Clear"
    case clouds = "Clouds"
    case unknown
    
    init(rawValue: String) {
        switch rawValue {
        case "Thunderstorm": self = .thunderstorm
        case "Drizzle": self = .drizzle
        case "Rain": self = .rain
        case "Snow": self = .snow
        case "Clear": self = .clear
        case "Clouds": self = .clouds
        default: self = .unknown
        }
    }
    
    var systemImageName: String {
        switch self {
        case .thunderstorm: return "cloud.bolt.rain.fill"
        case .drizzle: return "cloud.drizzle.fill"
        case .rain: return "cloud.rain.fill"
        case .snow: return "cloud.snow.fill"
        case .atmosphere: return "cloud.fog.fill"
        case .clear: return "sun.max.fill"
        case .clouds: return "cloud.fill"
        case .unknown: return "questionmark"
        }
    }
}
