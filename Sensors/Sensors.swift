//
//  Sensors.swift
//  Map PrototypeUITests
//
//  Created by Esteban Linarez  on 3/18/25.
//

import Foundation

struct Sensors: Codable {
    var name: String
    var sensor_id: Int
    var description: String?
    var lat: Double
    var lng: Double
    var start_date: String
    var type: String 
}

@Observable
class SensorModel {
    var sensor: Sensors?
    var sensors: [Sensors] = []
    
    func fetchSensors() async -> [Sensors] {
        let url = URL(string: "https://caslab.case.edu/air/el.php?data=sensors")
        let session = URLSession(configuration: .default)
        
        if let url = url {
            let urlRequest = URLRequest(url: url)
            do {
                let jsonDecoder = JSONDecoder()
                let (data, _) = try await session.data(for: urlRequest)
                let sensors = try jsonDecoder.decode([Sensors].self, from: data)
                return sensors
            } catch {
                print(error)
            }
        }
        return []
    }
}
