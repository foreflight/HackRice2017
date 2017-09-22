//: Playground - noun: a place where people can play

import UIKit
import MapKit
import CoreLocation

struct TrackPoint: Decodable {
    let timestamp: Date
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let course: CLLocationDegrees
    let speed_kts: Double
    let altitude_ft: Double
    let pressure_altitude_ft: String
    let source: Int
    let accuracy_horiz: Int
    let accuracy_vert: Int
    let bank: Double
    let pitch: Double
}

if let fileURL = Bundle.main.url(forResource: "convertcsv", withExtension: "json") {
    let data = try! Data(contentsOf: fileURL)
    let decoder = JSONDecoder()
    let trackLog = try! decoder.decode([TrackPoint].self, from: data)
    print(trackLog ?? "None")
}


