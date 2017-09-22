//: Playground - noun: a place where people can play

import UIKit

let trackLog = getTrackPoints()
let (takeOffTimeStamps, landingTimeStamps) = takeOffAndLandingTimeStamps(tracklog: trackLog)
print(takeOffTimeStamps)
print(landingTimeStamps)

let altitude = trackLog.map { $0.altitude_ft }
