//
//  AirQualityLabel.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 1/26/25.
//

import _MapKit_SwiftUI
import SwiftUI

struct AirQualityLabel: View{
    
    var marker: AirQualityMarker
    @Binding var showSheet:Bool
    @Binding var currentMarker: AirQualityMarker?
    
    var body: some View{
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
            print("Annotation \(marker.id) was tapped")
            self.showSheet = true
            self.currentMarker = marker
        }
    }
}
