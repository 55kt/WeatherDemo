//
// Extensions.swift
// WeatherDemo
//
// Created by Vlad on 31/8/25.

import Foundation
import SwiftUI

// MARK: - Double Extension
extension Double {
    // Converts a Double to a string rounded to the nearest integer
    func roundDouble() -> String {
        String(format: "%.0f", self)
    }
}

// MARK: - View Extension
extension View {
    // Applies rounded corners to specific corners of a view
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - RoundedCorner Shape
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    // Defines a path for rounded corners on specified corners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
