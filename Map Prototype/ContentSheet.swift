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
    
    var body: some View {
        ScrollView{
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
        .presentationDetents([.height(250), .medium, .large])
        .presentationBackgroundInteraction(.enabled(upThrough: .large)
        )
    }
}
