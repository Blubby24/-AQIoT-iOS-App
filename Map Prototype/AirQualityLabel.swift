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
    var onClick: () -> Void
    
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
            // I also need to center the map on the label on click here
            onClick()
        }
    }
}
