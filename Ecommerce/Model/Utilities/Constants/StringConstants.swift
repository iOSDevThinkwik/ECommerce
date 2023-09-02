//
//  StringConstants.swift
//  Shotdeck
//
//  Created by HEMANG SOLANKI on 11/10/22.
//

import Foundation
import UIKit
class StringConstants {
    
    //Common
    static var APP_NAME = "SHOTDECK"
    static var PLATFORM = "iOS"
    static var DEVICE_DETAILS = UIDevice.current.name
    static var OS_VERSION = UIDevice.current.systemVersion
    static var APP_VERSION = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    static var APP_VERSION_CODE = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
}
