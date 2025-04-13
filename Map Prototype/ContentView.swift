//
//  ContentView.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 11/14/24.
//

import SwiftUI

struct ContentView: View {
    @State var showSheet = false
    @State var currentMarker:AirQualityMarker?    
    var body: some View {
        TabView {
            VStack {
                AirQuilityMap(showSheet: $showSheet, currentMarker: $currentMarker)
                    .sheet(isPresented: $showSheet) {
                        ContentSheet(showSheet: $showSheet,
                                     currentMarker: $currentMarker)
                    }
            }
            .tabItem {
                Image(systemName: "globe")
                Text("Map")
            }
            
            SensorList()
                .tabItem {
                    Image(systemName: "air.purifier.fill")
                    Text("Sensors")
                }
            
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("About")
                }
        }
        .tint(.accentColor)
    }
}

#Preview {
    ContentView()
}
