//
//  DashBoardView.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI
import Charts

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



struct DashBoardView: View {
    
    @State var model = ReadingsModel()
    @State var dailytime = [String]()
    @State var dailyPM25 = [Int]()
    
    var dailyReadings: [(String, Int)] {
        return zip(dailytime, dailyPM25).map { ($0, $1) }
    }
    
    var body: some View {
        VStack {
            Text("Readings for given AQ sensor")
                .font(.headline)
                .fontWeight(.bold)
            // line chart showing PM2.5 readings for today.
            if !model.readings.isEmpty {
                Chart {
                    ForEach(dailyReadings, id: \.0) { (time, pm25) in
                        
                        LineMark(
                            x: .value("daily time", time),
                            y: .value("PM2.5", pm25)
                        )
                        .foregroundStyle(.green)
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 2))
                        .symbol(.circle)
                        .symbolSize(30)
                    }
                }
                .chartXAxis {
                    let indices = stride(from: 0, to: dailytime.count, by: max(1, dailytime.count / 6))
                    let xLabels = indices.map { dailytime[$0] }
                    
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
                .frame(height: 300)
                .padding(.horizontal)
            }
        }
        .task {
            model.readings = await model.getReadings()
            let sortedReadings = model.readings.sorted { $1.date > $0.date }
            dailytime = filterTodaysReadings(sortedReadings).map { $0.date }
            dailyPM25 = filterTodaysReadings(sortedReadings).map { $0.pm25 }
        }
    }
}

    
#Preview {
    DashBoardView()
}
