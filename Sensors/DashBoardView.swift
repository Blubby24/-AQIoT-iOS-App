//
//  DashBoardView.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI
import Charts

/*
func currentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
}


func filterTodaysReadings(_ readings: [Reading]) -> [Reading] {
    let todaysReadings = readings.filter { reading in
        let currentDay = currentDate()
        return reading.date.hasPrefix(currentDay)
    }
    return todaysReadings
}
*/


struct DashBoardView: View {
    @Binding var sensor: Sensors
    @State var dailyReadings: [Reading] = []
    @State var weeklyReadings: [Reading] = []
    @State var monthlyReadings: [Reading] = []
    @State var model = ReadingsModel()
 
    var body: some View {
        ScrollView {
            VStack {
                Text("Readings for given \(sensor.name)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                // sensor readings
                SensorReadings(title: .constant("Daily Readings"), sensor: .constant(sensor), readings: .constant(dailyReadings))
                SensorReadings(title: .constant("Weekly Readings"), sensor: .constant(sensor), readings: .constant(weeklyReadings))
                SensorReadings(title: .constant("Monthly Readings"), sensor: .constant(sensor), readings: .constant(monthlyReadings))
                // bar graphs for daily, weekly, and monthly averages, should all be in one graph???
                
                
                
            }
            .task {
                dailyReadings = await model.getReadings(limit: 1, sensorId: sensor.sensor_id)
                weeklyReadings = await model.getReadings(limit: 7, sensorId: sensor.sensor_id)
                monthlyReadings = await model.getReadings(limit: 30, sensorId: sensor.sensor_id)
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
    
    DashBoardView(sensor: .constant(sensor))
}
