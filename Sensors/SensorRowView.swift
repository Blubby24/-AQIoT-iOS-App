//
//  SensorRowView.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI

struct SensorRowView: View {
    
    @Binding var sensor: Sensors
    var body: some View {
        HStack{
            Image(systemName: "sensor.fill")
            
            VStack(alignment: .leading){
                HStack {
                    Text(sensor.name)
                        .font(.headline)
                    Spacer()
                    Text("online")
                        .font(.headline)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .padding()
                }
                Text(sensor.description ?? "no description")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical)
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
                                                    
    SensorRowView(sensor: .constant(sensor))
}
