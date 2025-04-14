//
//  AirQuilityMarker.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 11/14/24.
//
import SwiftUI
import MapKit
import CoreLocation

struct AirQualityMarker: Identifiable {
    var id = UUID()
    var imageName: String
    var radius: Double
    var sensor: Sensors
    let readingModel: ReadingsModel
    var cachedReading: Double? = nil
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: sensor.lat, longitude: sensor.lng)
    }
    
    func getAQColor(for value: Double?) -> Color {
        guard let value = value else { return .gray }
        switch value {
        case 0..<20: return .green
        case 20..<40: return .orange
        default: return .red
        }
    }

    func getMarkerSymbol(for value: Double?) -> String {
        guard let value = value else { return "questionmark.circle" }
        switch value {
        case 0..<20: return "sun.min"
        case 20..<40: return "wind"
        default: return "smoke"
        }
    }
}

extension AirQualityMarker {
    init(sensor: Sensors, readingModel: ReadingsModel, imageName: String = "smoke.fill", radius: Double = 40) {
        self.sensor = sensor
        self.readingModel = readingModel
        self.imageName = imageName
        self.radius = radius
        self.cachedReading = nil
    }
}

