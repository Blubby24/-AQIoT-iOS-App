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
    @Binding var isCWRUDeployed: Bool
    @Binding var isDaily: Bool
    @State var defaultSensor = Sensors(
        name: "test",
        sensor_id: 80,
        description: "sensor detecting air quality",
        lat: 12.34,
        lng: 56.78,
        start_date: "2025-03-27 09:01:00",
        type: "OUTDOOR"
    )
    
    
    func formatDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "MM/dd"
            return formatter.string(from: date)
        }
        
        return date
    }
    
    
    /* function to get average readings for cwru deployed */
    func computeAvgReadings(_ sensor: Sensors) -> [Reading] {
        var avgReadings: [Reading] = []
        var average = 0;
        var count = 0;
        let minuteAverage = 20;
        
        
        if sensor.type != "CWRUDeployed" {
            return readings.sorted { $0.date < $1.date }
        }
        
        for reading in readings {
            average += reading.pm25
            count+=1
            
            if count == minuteAverage {
                average /= minuteAverage
                let newReading = Reading(reading_id: reading.reading_id,
                                  sensor_id: reading.sensor_id,
                                  date: reading.date,
                                  name: reading.name,
                                  pm25: average,
                                  lat: reading.lat,
                                  lng: reading.lng)
                
                avgReadings.append(newReading)
                average = 0
                count = 0
            }
        }
        
        return avgReadings.sorted { $0.date < $1.date }
    }
        
    var body: some View {
            VStack {
                Text("\(title) for \(sensor?.name ?? "default sensor")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                if !readings.isEmpty {
                    Chart {
                        ForEach(computeAvgReadings(sensor ?? defaultSensor), id: \.reading_id) { reading in
                            
                            LineMark(
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
                        let indices = stride(from: 0, to: readings.count, by: max(1, readings.count / 5))
                        let xLabels: [String] = indices.map {
                            let date = readings[$0].date
                            print(date)
                            return date
                        }
                        
                        AxisMarks(position: .bottom, values: xLabels){ value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel {
                                if let timeStr = value.as(String.self) {
                                    if isDaily {
                                        let timeStamp = formatDate(timeStr)
                                        Text(timeStamp)
                                            .rotationEffect(.degrees(-45))
                                    }
                                    else {
                                        let displayedText = formatDate(timeStr)
                                        Text(displayedText)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .frame(height: 330)
                }
        }
    }
}
/*
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
*/
