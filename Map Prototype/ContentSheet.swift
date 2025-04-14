//
//  ContentSheet.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 1/26/25.
//

import SwiftUI

struct ContentSheet: View {
    @Binding var showSheet:Bool
    @Binding var currentMarker:AirQualityMarker?
    @Binding var sensor:Sensors?
    
    var body: some View {
        ScrollView{
            VStack() {
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.showSheet = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.secondary)
                            .padding(4)
                    }
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
                Spacer()
                if let sensor = sensor {
                    ZStack {
                            DashBoardView(sensor: Binding(
                                get: { sensor },
                                set: { self.sensor = $0 }
                            ))
                        }
                    }
                else{
                    Text("Failed to get a reading")
                        .padding()
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            .onAppear {
                if let marker = currentMarker {
                    sensor = marker.sensor
                }
            }
        }
        .presentationDetents([.height(250), .medium, .large])
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
}
