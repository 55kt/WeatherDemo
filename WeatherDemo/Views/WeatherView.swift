//
// WeatherView.swift
// WeatherDemo
//
// Created by Vlad on 31/8/25.

import SwiftUI

struct WeatherView: View {
    // MARK: - Properties
    let weather: ResponseBody
    private var condition: WeatherCondition {
        WeatherCondition(rawValue: weather.weather.first?.main ?? "")
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .leading) {
            // Main content: location, date, weather condition, and image
            VStack {
                // Location and timestamp
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // Weather condition and temperature
                VStack {
                    HStack {
                        VStack(spacing: 0) {
                            Image(systemName: condition.systemImageName)
                                .font(.system(size: 40))
                            
                            Text(condition.rawValue)
                                .padding(.top, 5)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 35)
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 80)
                    
                    // Cityscape image
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Weather details panel
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    // Temperature rows
                    HStack {
                        WeatherRow(
                            logo: "thermometer",
                            name: "Min temp",
                            value: weather.main.tempMin.roundDouble() + "°"
                        )
                        Spacer()
                        WeatherRow(
                            logo: "thermometer",
                            name: "Max temp",
                            value: weather.main.tempMax.roundDouble() + "°"
                        )
                    }
                    
                    // Wind and humidity rows
                    HStack {
                        WeatherRow(
                            logo: "wind",
                            name: "Wind speed",
                            value: weather.wind.speed.roundDouble() + " m/s"
                        )
                        Spacer()
                        WeatherRow(
                            logo: "humidity",
                            name: "Humidity",
                            value: weather.main.humidity.roundDouble() + "%"
                        )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundStyle(Color(red: 0.066, green: 0.087, blue: 0.346))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(red: 0.066, green: 0.087, blue: 0.346))
        .preferredColorScheme(.dark)
    }
}

// MARK: - Preview
#Preview {
    WeatherView(weather: previewWeather)
}
