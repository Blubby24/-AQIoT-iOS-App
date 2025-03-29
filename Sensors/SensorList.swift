//
//  SensorList.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI

struct SensorList: View {
    @State var sensors: [Sensors] = [Sensors(sensorId: 34567, name: "test", type: "aq sensor", description: "sensor detecting air quality"), Sensors(sensorId: 43532, name: "test2", type: "aq sensor", description: "aq sensor")]
    
    @State var model = ReadingsModel()
    
    
    var body: some View {
        VStack{
            Text("model readings: \(model.readings.first)")
            
            List($sensors, id: \.id){ $sensor in
                NavigationLink{
                    DashBoardView()
                } label: {
                    SensorRowView(sensor: .constant(sensor))
                }
            }
        }
        .navigationTitle("Sensors")
        .frame(maxHeight: .infinity, alignment: .top)
        .task {
            model.readings = await model.getReadings()
        }
    }
}

#Preview {
    SensorList()
}
