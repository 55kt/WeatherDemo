//
// LocationManager.swift
// WeatherDemo
//
// Created by Vlad on 31/8/25.

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - Properties
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading: Bool = false
    
    // MARK: - Initialization
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // MARK: - Public Methods
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Update location with first available coordinate
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        // Log error and reset loading state
        print("Failed to get location: \(error)")
        isLoading = false
    }
}
