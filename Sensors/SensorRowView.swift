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
                Text(sensor.name)
                    .font(.headline)
                Text(sensor.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

#Preview {
    @State @Previewable var sensor: Sensors = Sensors(sensorId: 34567, name: "test", type: "aq sensor", description: "sensor detecting air quality")
                                                    
    SensorRowView(sensor: .constant(sensor))
}
