//
//  File.swift
//  Map Prototype
//
//  Created by Esteban Linarez  on 3/28/25.
//

import Foundation


struct Reading: Codable{
    var reading_id: Int64
    var sensor_id: Int64
    var date: String
    var name: String
    var pm25: Int
    var lat: Double
    var lng: Double
    
    func getDateFormat(_ date:Date)-> String{
        let dataFormatter = DateFormatter()
        dataFormatter.locale = Locale(identifier: "en_US")
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dataFormatter.string(from: date)
    }
    
}

@Observable
class ReadingsModel {
    var reading: Reading?
    var readings: [Reading] = []
    
    func getReadings(limit: Int, sensorId: Int? = nil) async -> [Reading] {
        let endpoint = URL(
            string: "https://caslab.case.edu/air/el.php?data=readings&limit=\(limit)&sensor_id=\(sensorId ?? 4)"
        )
        let session = URLSession(configuration: .default)
        
        if let url = endpoint {
            let urlRequest = URLRequest(url: url)
            do {
                let jsonDecoder = JSONDecoder()
                let (data, _) = try await session.data(for: urlRequest)
                let readings = try jsonDecoder.decode([Reading].self, from: data)
                return readings
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        return []
    }
}
