//
//  Float+Extensions.swift
//  Shotdeck
//
//  Created by HEMANG SOLANKI  on 25/01/22.
//

import Foundation

extension Float {
    func stringValue(floatingPoint: Int = -1) -> String {
        var flPoint = "%f"
        if floatingPoint != -1 {
            flPoint = "%.\(floatingPoint)f"
        }
        return String(format: flPoint, self)
    }
}
