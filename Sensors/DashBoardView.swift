//
//  DashBoardView.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI
import Charts

struct DashBoardView: View {
    @Binding var sensor: Sensors
    @State var isCWRUDeployed: Bool = false
    @State var dailyReadings: [Reading] = []
    @State var weeklyReadings: [Reading] = []
    @State var monthlyReadings: [Reading] = []
    @State var model = ReadingsModel()
    @State var isDaily: Bool = true
    
    func checkCWRUDeployment(sensor: Sensors) -> Bool {
        guard sensor.type == "CWRUDeployed" else {
            return false
        }
        return true
    }
 
    var body: some View {
        ScrollView {
            VStack {
                Text("Readings for given \(sensor.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                
                /* information listed about each sensor */
                SensorInfo(sensor: $sensor)
                // sensor readings
                SensorReadings(title: .constant("Daily PM25 Readings"), sensor: .constant(sensor), readings: .constant(dailyReadings), isCWRUDeployed: .constant(checkCWRUDeployment(sensor: sensor)), isDaily: .constant(true))
                SensorReadings(title: .constant("Weekly PM25 Readings"), sensor: .constant(sensor), readings: .constant(weeklyReadings), isCWRUDeployed: .constant(checkCWRUDeployment(sensor: sensor)), isDaily: .constant(false))
                SensorReadings(title: .constant("Monthly PM25 Readings"), sensor: .constant(sensor), readings: .constant(monthlyReadings), isCWRUDeployed: .constant(checkCWRUDeployment(sensor: sensor)), isDaily: .constant(false))
                // bar graphs for daily, weekly, and monthly averages, should all be in one graph???
                BarChart(sensor: .constant(sensor), dailyData: .constant(dailyReadings), weeklyData: .constant(weeklyReadings), monthlyData: .constant(monthlyReadings))
                
                
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
