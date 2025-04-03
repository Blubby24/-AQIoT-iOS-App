//
//  SensorReadings.swift
//  Map Prototype
//
//  Created by Esteban Linarez  on 4/2/25.
//

import SwiftUI
import Charts

struct SensorReadings: View {
    @Binding var title: String
    @Binding var sensor: Sensors?
    @Binding var readings: [Reading]
    
    var body: some View {
            VStack {
                Text("\(title) for \(sensor?.name ?? "default")")
                    .font(.headline)
                    .fontWeight(.bold)
                if !readings.isEmpty {
                    Chart {
                        ForEach(readings, id: \.reading_id) { reading in
                            
                            LineMark (
                                x: .value("date", reading.date),
                                y: .value("value", reading.pm25)
                            )
                            .foregroundStyle(.green)
                            .interpolationMethod(.catmullRom)
                            .lineStyle(.init(lineWidth: 2))
                            .symbolSize(30)
                        }
                    }
                    .chartXAxis{
                        let indices = stride(from: 0, to: readings.count, by: max(1, readings.count / 6))
                        let xLabels = indices.map(\.self)
                        
                        AxisMarks(position: .bottom, values: xLabels){ value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel {
                                if let timeStr = value.as(String.self) {
                                    let time = timeStr.suffix(8)
                                    Text(time)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 300)
                }
        }
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
    
    //@State @Previewable var readings: [Reading] = []
    //SensorReadings(sensor: .constant(sensor), readings: .constant(readings))
}
