//
// ContentView.swift
// WeatherDemo
//
// Created by Vlad on 30/8/25.

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var locationManager = LocationManager()
    private let weatherManager = WeatherManager()
    @State private var weather: ResponseBody?

    // MARK: - Body
    var body: some View {
        VStack {
            // Handle location availability
            if let location = locationManager.location {
                if let weather {
                    // Display weather data when available
                    WeatherView(weather: weather)
                } else {
                    // Fetch weather data while showing loading state
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(
                                    latitude: location.latitude,
                                    longitude: location.longitude
                                )
                            } catch {
                                print("Failed to fetch weather: \(error)")
                            }
                        }
                }
            } else {
                // Handle location loading or unavailable states
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(red: 0.066, green: 0.087, blue: 0.346))
        .preferredColorScheme(.dark)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
