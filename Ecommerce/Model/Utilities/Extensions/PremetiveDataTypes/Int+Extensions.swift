//
//  Int+Extensions.swift
//  Shotdeck
//
//  Created by Shotdeck_Developer on 11/10/22.
//

import Foundation
extension Int {
    func toString() -> String {
        return String(self)
    }
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    func toFloat() -> Float {

        return Float.init(self)
    }
    func toCGFloat() -> CGFloat {

        return CGFloat.init(self.toFloat())
    }
    func asTimeString() -> String {
        return toTimeParts().description
    }
    
    func toTimeParts() -> TimeParts {
        let seconds = self
        var mins = 0
        var secs = seconds
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = seconds - (mins * 60)
        }
        
        return TimeParts(seconds: secs, minutes: mins)
    }
}

struct TimeParts: CustomStringConvertible {
    var seconds = 0
    var minutes = 0
    /// The string representation of the time parts (ex: 07:37)
    var description: String {
        return NSString(format: "%01d:%02d", minutes, seconds) as String
    }
}
