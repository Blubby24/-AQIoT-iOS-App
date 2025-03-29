//
//  Sensors.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import Foundation

struct Sensors: Identifiable, Codable {
    var id = UUID()
    var sensorId: UInt64
    var name: String
    var type: String
    var description: String
}
