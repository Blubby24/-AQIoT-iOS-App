//
//  AirQuilityMarker.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 11/14/24.
//
import SwiftUI
import MapKit
import CoreLocation

struct AirQualityMarker: Identifiable{
    
    
    var id = UUID()
    var title: String
    var coordinate: CLLocationCoordinate2D
    var imageName: String
    var radius: Double
    var airQuality:Int
    
    // Initializer
    init(title: String, coordinate: CLLocationCoordinate2D, imageName: String, radius:Double=50, airQuality:Int) {
        self.title = title
        self.coordinate = coordinate
        self.imageName = imageName
        self.radius = radius
        self.airQuality = airQuality
    }
    
    func getAQColor() -> Color{
        // A good idea would be change this so that it starts very green and becomes more red over time continuously 
        // Some kind of gradiant from green to yellow to organge to red
        if(self.airQuality <= 20){
            return Color.green
        }
        if(self.airQuality <= 40){
            return Color.orange
        }
        return Color.red
    }
    
    func getMarkerSymbol() -> String{
        if(self.airQuality <= 20){
            return "sun.min"
        }
        if(self.airQuality <= 40){
            return "wind"
        }
        return "smoke"
    }
    
    func getAQData() -> Dictionary<String, String>{
        return [
            "title": self.title,
            "Air Qulity Number": String(self.airQuality)
        ]
    }
    
}
