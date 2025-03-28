//
//  DashBoardView.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import SwiftUI
import Charts

struct DashBoardView: View {
    var body: some View {
        Chart {
            BarMark(x: .value("Type", "sensor1"), y: .value("AQ Quality", 4.5))
                .foregroundStyle(.pink)
            
            BarMark(x: .value("Type", "sensor2"),y: .value("AQ Quality", 2))
                        .foregroundStyle(.green)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    DashBoardView()
}
