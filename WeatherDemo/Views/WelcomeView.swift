//
// WelcomeView.swift
// WeatherDemo
//
// Created by Vlad on 31/8/25.

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    // MARK: - Properties
    @EnvironmentObject private var locationManager: LocationManager
    
    // MARK: - Body
    var body: some View {
        VStack {
            // Introductory text
            VStack(spacing: 20) {
                Text("Welcome to the Weather App")
                    .bold()
                    .font(.title)
                
                Text("Please share your current location to get the weather in your area.")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            // Location request button
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .symbolVariant(.fill)
            .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview
#Preview {
    WelcomeView()
        .environmentObject(LocationManager())
}
