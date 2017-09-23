import Foundation

enum FlightState {
    case OnTheGround
    case InTheAir
}

public func takeOffAndLandingTimeStamps(tracklog:[TrackPoint]) -> (takeOffTimeStamps:[Date],landingTimeStamps:[Date]) {
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
