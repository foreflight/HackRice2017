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
}

enum FlightState {
    case OnTheGround
    case InTheAir
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

public func takeOffAndLandingTimeStamps(tracklog:Array<TrackPoint>) -> (takeOffTimeStamps:Array<Date>,landingTimeStamps:Array<Date>) {
    var takeOffTimeStamps: Array<Date> = []
    var landingTimeStamps: Array<Date> = []
    var flightState: FlightState = .OnTheGround
    for currentValue in tracklog {
        if flightState == .OnTheGround && currentValue.speed_kts > 60 {
            flightState = .InTheAir
            takeOffTimeStamps.append(currentValue.timestamp)
        }
        else if flightState == .InTheAir && currentValue.speed_kts < 40 {
            flightState = .OnTheGround
            landingTimeStamps.append(currentValue.timestamp)
        }
    }
    return (takeOffTimeStamps, landingTimeStamps)
}

