import Foundation
import CoreLocation

public struct TrackPoint: Decodable {
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


public func getTrackPoints() -> [TrackPoint] {
    var trackPoints = [TrackPoint]()
    if let fileURL = Bundle.main.url(forResource: "convertcsv", withExtension: "json") {
        let data = try! Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        if let decodedPoints = try? decoder.decode([TrackPoint].self, from: data) {
            trackPoints = decodedPoints
        }
    }
    return trackPoints
}

