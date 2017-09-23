import Foundation
import CoreLocation

public struct TrackPoint: Decodable {
    public let timestamp: Date
    public let latitude: CLLocationDegrees
    public let longitude: CLLocationDegrees
    public let course: CLLocationDegrees
    public let speed_kts: Double
    public let altitude_ft: Double
    public let pressure_altitude_ft: String
    public let source: Int
    public let accuracy_horiz: Int
    public let accuracy_vert: Int
    public let bank: Double
    public let pitch: Double
    
    init(trackPointWithBadTimestamp: TrackPoint) {
        // JSON is using seconds since 1970, but the decoder is using 1/1/2001.
        // Reverse this bad conversion to get the correct date.
        self.timestamp = Date(timeIntervalSince1970: trackPointWithBadTimestamp.timestamp.timeIntervalSinceReferenceDate)
        self.latitude = trackPointWithBadTimestamp.latitude
        self.longitude = trackPointWithBadTimestamp.longitude
        self.course = trackPointWithBadTimestamp.course
        self.speed_kts = trackPointWithBadTimestamp.speed_kts
        self.altitude_ft = trackPointWithBadTimestamp.altitude_ft
        self.pressure_altitude_ft = trackPointWithBadTimestamp.pressure_altitude_ft
        self.source = trackPointWithBadTimestamp.source
        self.accuracy_horiz = trackPointWithBadTimestamp.accuracy_horiz
        self.accuracy_vert = trackPointWithBadTimestamp.accuracy_vert
        self.bank = trackPointWithBadTimestamp.bank
        self.pitch = trackPointWithBadTimestamp.pitch
    }
}

public func getTrackPoints() -> [TrackPoint] {
    var trackPoints = [TrackPoint]()
    if let fileURL = Bundle.main.url(forResource: "FlightData", withExtension: "json") {
        let data = try! Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        if let decodedPoints = try? decoder.decode([TrackPoint].self, from: data) {
            trackPoints = decodedPoints
        }
    }
    trackPoints = trackPoints.map {
        TrackPoint(trackPointWithBadTimestamp: $0)
    }
    return trackPoints
}

