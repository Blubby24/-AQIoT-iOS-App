//
//  AirQuilityMap.swift
//  Map Prototype
//
//  Created by Dorian Hawkins on 11/14/24.
//

import SwiftUI
import MapKit

struct AirQuilityMap: View {
    @State private var sensorModel = SensorModel()
    let readingModel = ReadingsModel()

    @State private var markers: [AirQualityMarker] = []
    @State private var position: MapCameraPosition = .userLocation(
        fallback: .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 41.50416, longitude: -81.60845),
            span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    )

    @Binding var showSheet: Bool
    @Binding var currentMarker: AirQualityMarker?

    var body: some View {
        Map(position: $position) {
            ForEach(markers) { marker in
                let color = marker.getAQColor(for: marker.cachedReading)

                MapCircle(center: marker.coordinate, radius: marker.radius)
                    .foregroundStyle(color.opacity(0.3))

                Annotation(marker.sensor.name, coordinate: marker.coordinate) {
                    AirQualityLabel(marker: marker, onClick: {
                        self.showSheet = true
                        self.currentMarker = marker
                        withAnimation {
                            position = .region(MKCoordinateRegion(
                                center: marker.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)))
                        }
                    })
                }
            }
        }
        .onAppear {
            loadMarkersFromSensors()
        }
    }

    func loadMarkersFromSensors() {
        Task {
            let sensors = await sensorModel.fetchSensors()
            let mappedMarkers = sensors.map { sensor in
                AirQualityMarker(sensor: sensor, readingModel: readingModel, imageName: "sensor", radius: 50)
            }

            var enrichedMarkers: [AirQualityMarker] = []
            for var marker in mappedMarkers {
                /* check if we need sort readings here because I noticed on graphs when adding dates tickmarks were in decending order for dates */
                let reading = await readingModel.getReadings(limit: 1, sensorId: marker.sensor.sensor_id).first?.pm25 ?? -1
                marker.cachedReading = Double(reading)
                enrichedMarkers.append(marker)
            }

            markers = enrichedMarkers
        }
    }
}
