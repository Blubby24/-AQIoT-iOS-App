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
        VStack {
            AirQuilityMap(showSheet: $showSheet, currentMarker: $currentMarker)
            // This can't be the best way to do this
                .overlay(content:{
                    if showSheet {
                        VStack{
                            Spacer()
                            ContentSheet(showSheet: $showSheet,
                                         currentMarker: $currentMarker)
                            .frame(maxHeight: UIScreen.main.bounds.height / 4)
                            .transition(.move(edge: .bottom))
                            .background(.white)
                            .opacity(1.0)
                        }
                    }
                })
        }
    }
}

#Preview {
    ContentView()
}
