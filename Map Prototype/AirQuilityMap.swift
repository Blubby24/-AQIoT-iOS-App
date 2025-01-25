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
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.50416, longitude: -81.60845),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @Binding var showSheet: Bool
    @Binding var currentMarker: AirQualityMarker?
    
    var body: some View {
        Map{
            ForEach(markers){ marker in
                MapCircle(center:marker.coordinate, radius:marker.radius)
                    .foregroundStyle(marker.getAQColor().opacity(0.30))
                
                Annotation(marker.title, coordinate:marker.coordinate) {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                        
                        Circle()
                            .stroke(marker.getAQColor(), lineWidth: 3)
                            .frame(width: 29, height: 29)
                        
                        Text(String(marker.airQuality))
                            .font(.system(size: 10))
                            .bold()
                            .foregroundColor(.black)
                    }
                    .shadow(radius: 3, x: 0, y: 2)
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        // This is where we put the on click functionality
                        print("Annotation \(marker.id) was tapped")
                        self.showSheet = true
                        self.currentMarker = marker
                    }
                }
            }
        }
    }
}

struct ContentSheet: View {
    @Binding var showSheet:Bool
    @Binding var currentMarker:AirQualityMarker?
    
    var body: some View {
        VStack() {
            HStack{
                Button(action: {
                    self.showSheet = false
                }) {
                    Text("Close")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
            }
            Spacer()
            if !(currentMarker == nil){
                ZStack{
                    Circle()
                        .stroke(currentMarker!.getAQColor(), lineWidth: 3)
                        .frame(width: 50, height: 50)
                    Text(String(currentMarker!.airQuality))
                        .padding()
                        .foregroundColor(.black)
                        .cornerRadius(8)

                }
                Spacer()
            }
            
        }
        .background(Color.gray.opacity(0.1))
    }
}



