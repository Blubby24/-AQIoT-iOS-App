//
//  AirQuilityMap.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 11/14/24.
//
import SwiftUI
import MapKit

struct AirQuilityMap: View{
    // We need some way to bring in the actual data. Also we need to get a better radius for these sensors. 
    let markers = [
        AirQualityMarker(title: "Case Western Reserve",
                         coordinate: CLLocationCoordinate2D(latitude: 41.50416, longitude: -81.60845),
                         imageName: "monument", airQuality:20),
        AirQualityMarker(title: "Kyle",
                         coordinate: CLLocationCoordinate2D(latitude: 41.50516, longitude: -81.60845),
                         imageName: "monument", airQuality:40),
        AirQualityMarker(title: "Andrew",
                         coordinate: CLLocationCoordinate2D(latitude: 41.50616, longitude: -81.60845),
                         imageName: "monument", airQuality:80)]
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.50416, longitude: -81.60845), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))))
    
    @Binding var showSheet: Bool
    @Binding var currentMarker: AirQualityMarker?
    
    var body: some View {
        Map(position: $position){
            ForEach(markers){ marker in
                MapCircle(center:marker.coordinate, radius:marker.radius)
                    .foregroundStyle(marker.getAQColor().opacity(0.30))
                
                Annotation(marker.title, coordinate:marker.coordinate) {
                    AirQualityLabel(marker: marker, onClick: {
                        self.showSheet = true
                        self.currentMarker = marker
                        withAnimation {
                            position = .region(MKCoordinateRegion(center:marker.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)))
                        }
                    })
                }
            }
        }
    }
}

