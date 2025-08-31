//
// WeatherManager.swift
// WeatherDemo
//
// Created by Vlad on 31/8/25.

import Foundation
import CoreLocation

class WeatherManager {
    // MARK: - Methods
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        // Construct API URL with metric units
        let apiKey: String = "your_api_weather_key"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric") else {
            fatalError("Invalid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        // Fetch weather data
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Validate HTTP response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            fatalError("Failed to fetch weather data")
        }
                
        // Decode response
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// MARK: - Data Models
struct ResponseBody: Decodable {
    let coord: CoordinatesResponse
    let weather: [WeatherResponse]
    let main: MainResponse
    let name: String
    let wind: WindResponse

    struct CoordinatesResponse: Decodable {
        let lon: Double
        let lat: Double
    }

    struct WeatherResponse: Decodable {
        let id: Double
        let main: String
        let description: String
        let icon: String
    }

    struct MainResponse: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Double
        let humidity: Double
    }
    
    struct WindResponse: Decodable {
        let speed: Double
        let deg: Double
    }
}

// MARK: - Extensions
extension ResponseBody.MainResponse {
    var feelsLike: Double { feels_like }
    var tempMin: Double { temp_min }
    var tempMax: Double { temp_max }
}
