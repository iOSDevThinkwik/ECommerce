//
//  FontsConstants.swift
//  Shotdeck
//
//  Created by HEMANG SOLANKI on 11/10/22.
//

import Foundation
import UIKit

enum AppFont: String {
    case Inter = "Inter"
}

enum AppFontFamily: String {
    
    case Black = "Black"
    case Bold = "Bold"
    case ExtraBold = "ExtraBold"
    case ExtraLight = "ExtraLight"
    case Light = "Light"
    case Medium = "Medium"
    case Regular = "Regular"
    case SemiBold = "SemiBold"
    case Thin = "Thin"
    
}

class Fonts {
    private var appFont: AppFont = .Inter
    static private var shared: Fonts? = nil
    
    class func sharedObject() -> Fonts {
        if shared == nil {
            shared = Fonts()
        }
        return shared!
    }
    func getAppFontFont(family: AppFontFamily, size: CGFloat) -> UIFont {
        return UIFont.init(name: appFont.rawValue + "-" + family.rawValue, size: size)!
    }
    func getAppFontFont(customFont: AppFont, family: AppFontFamily, size: CGFloat) -> UIFont {
        return UIFont.init(name: customFont.rawValue + "-" + family.rawValue, size: size)!
    }
}
