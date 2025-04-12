//
//  SensorInfo.swift
//  Map Prototype
//
//  Created by Esteban Linarez  on 4/12/25.
//

import SwiftUI

struct SensorInfo: View {
    @Binding var sensor: Sensors
    
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Text("Sensor Information: ")
                        .font(.headline)
                        .foregroundStyle(.accent)
                    Spacer()
                }
                HStack {
                    Text("\(sensor.description ?? "no description provided")")
                        .foregroundStyle(.accent)
                    Spacer()
                }
            }
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Start Date")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(sensor.start_date)")
                        .foregroundStyle(.accent)
                }
                
                VStack{
                    Text("Sensor Type")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(sensor.type)")
                        .foregroundStyle(.accent)
                }
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.accent.opacity(0.3))
        )
        .overlay(alignment: .center){
            RoundedRectangle(cornerRadius: 25)
                .stroke(.accent.opacity(0.2), lineWidth: 1)
        }
        .padding()
    }
}

#Preview {
    @State @Previewable var sensor: Sensors = Sensors(
        name: "test",
        sensor_id: 80,
        description: "sensor detecting air quality",
        lat: 12.34,
        lng: 56.78,
        start_date: "2025-03-27 09:01:00",
        type: "OUTDOOR"
    )
    
    SensorInfo(sensor: $sensor)
}
