//
//  BarChart.swift
//  Map Prototype
//
//  Created by Esteban Linarez  on 4/5/25.
//


import SwiftUI
import Charts

func computeAvg(_ dataPoints: [Reading]) -> Double{
    guard !dataPoints.isEmpty else {
        return 0.0
    }
    
    var sum: Int = 0
    
    for dataPoint in dataPoints {
        sum += dataPoint.pm25
    }
    
    return Double(sum) / Double(dataPoints.count)
}

struct BarChart: View {
    @Binding var sensor: Sensors?
    @Binding var dailyData: [Reading]
    @Binding var weeklyData: [Reading]
    @Binding var monthlyData: [Reading]
    

    var body: some View {
        Text("PM25 Average for each time period")
            .font(.headline)
            .foregroundStyle(.accent)
        Chart {
            BarMark(
                x: .value("Daily", "Daily"),
                y: .value("daily avg: ", computeAvg(dailyData))
            )
            BarMark(
                x: .value("data", "Weekly"),
                y: .value("weekly avg: ", computeAvg(weeklyData))
            )
            BarMark(
                x: .value("data", "Monthly"),
                y: .value("monthly avg: ", computeAvg(monthlyData))
            )
        }
        .frame(height: 250)
        .foregroundStyle(.green)
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
    @Previewable @State var dailyData: [Reading] = []

    
    //BarChart(sensor: .constant(sensor), dailyData: .constant(dailyData), weeklyData: .constant(dailyData), monthlyData: .constant(dailyData))
}
*/
