//
//  SensorList.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI

struct SensorList: View {
    @State var model = SensorModel()
    @State var selectedSensor: Sensors?
    
    var body: some View {
        NavigationStack {
            VStack{
                    List($model.sensors, id: \.sensor_id){ $sensor in
                        NavigationLink{
                            // pass in selectedSensor as a binding
                            DashBoardView(sensor: $sensor)
                        } label: {
                            SensorRowView(sensor: .constant(sensor))
                        }
                }
            }
            .task {
                model.sensors = await model.fetchSensors()
            }
        }
        .navigationTitle("Sensors")
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    SensorList()
}
