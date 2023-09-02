//
//  Double+Extensnions.swift
//  Shotdeck
//
//  Created by Shotdeck_Developer on 11/10/22.
//

import Foundation
extension Double {
    func getSecondsToTime() -> String {
        let mins: Int = Int(self / 60)
        let secs: Int = Int(self.truncatingRemainder(dividingBy: 60))
        return "\(mins)" + ":" + "\(secs)"
    }
    func stringValue(floatingPoint: Int = -1) -> String {
        var flPoint = "%f"
        if floatingPoint != -1 {
            flPoint = "%.\(floatingPoint)f"
        }
        return String(format: flPoint, self)
    }
    func intValue() -> Int {
        return Int.init(self)
    }
    func cleanValue()->String?{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}
