//
//  String+Extensions.swift
//  Shotdeck
//
//  Created by Shotdeck_Developer on 11/10/22.
//

import Foundation
import UIKit

extension String {
    
    func getDateByString(currentFormat: String, desireFormat: String = "") -> String {
        
        let dateFromat = DateFormatter()
        dateFromat.timeZone = TimeZone(abbreviation: "UTC")
        dateFromat.dateFormat = currentFormat
        let date = dateFromat.date(from: self)
        if desireFormat.count > 0{
            dateFromat.dateFormat = desireFormat
        }else{
            dateFromat.dateFormat = "YYYY-mm-dd"
        }
        
        dateFromat.timeZone = TimeZone.current
        let strDate = dateFromat.string(from: date!)
        
        return strDate
    }
    
    func getDateTimeFrom(currentFormat: String, desireFormat: String = "YYYY-mm-dd", desireTimeZone: TimeZone = .current) -> String {
        let dateFromat = DateFormatter()
        dateFromat.dateFormat = currentFormat
        let date = dateFromat.date(from: self)
        dateFromat.dateFormat = desireFormat
        dateFromat.timeZone = desireTimeZone
        let strDate = dateFromat.string(from: date!)
        return strDate
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
    
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    //MARK: - Convert Value to Other Data Type -
    func toInt() -> Int {
        if self != "" {
            return Int.init(self) ?? 0
        }
        return 0
    }
    
    func toFloat() -> Float {
        if let num = NumberFormatter().number(from: self)?.floatValue{
            return num
        }
        return 0.0
    }
    
    //MARK: - Localization -
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    //MARK: - Color -
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    //MARK: - Validation -
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
        let filtered: String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return self == filtered
    }
    
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func trim()->String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    // MARK: - URL -
    func convertToURL() -> URL? {
        return URL.init(string: self)
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func stringToRGBA()-> UIColor? {
        var strResult = self.replace(target: "rgba", withString: "")
        strResult = strResult.replace(target: "(", withString: "")
        strResult = strResult.replace(target: ")", withString: "")
        let obj = strResult.components(separatedBy: ",")
        if obj.count == 4{
            let r = obj[0].CGFloatValue
            let g = obj[1].CGFloatValue
            let b = obj[2].CGFloatValue
            let a = obj[3].CGFloatValue
            let uicolor = UIColor.init(red: r()!/255, green: g()!/255, blue: b()!/255, alpha: a()!)
            return  uicolor
        }else{
            return nil
        }
    }
    
    func stringToRGB()-> UIColor? {
        var strResult = self.replace(target: "rgba", withString: "")
        strResult = strResult.replace(target: "(", withString: "")
        strResult = strResult.replace(target: ")", withString: "")
        let obj = strResult.components(separatedBy: ",")
        if obj.count == 4{
            let r = obj[0].CGFloatValue
            let g = obj[1].CGFloatValue
            let b = obj[2].CGFloatValue
            let a = obj[3].CGFloatValue
            
            let uicolor = UIColor.init(red: Int(r()!)/255, green: Int(g()!)/255, blue: Int(b()!)/255)
            return  uicolor
        }else{
            return nil
        }
    }
    
    func newStringToRgba()-> String?{
        var strResult = self.replace(target: "rgba", withString: "")
        strResult = strResult.replace(target: "(", withString: "")
        strResult = strResult.replace(target: ")", withString: "")
        let obj = strResult.components(separatedBy: ",")
        if obj.count == 4{
            let r = obj[0].CGFloatValue
            let g = obj[1].CGFloatValue
            let b = obj[2].CGFloatValue
            let a = obj[3].CGFloatValue
            
            let uicolor = UIColor.init(red: r()!/255, green: g()!/255, blue: b()!/255, alpha: a()!)
            let new = uicolor as? String? ?? "rgb(00,0,00)"
            return  new
        }else{
            return nil
        }
    }
    
    var encoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
   
    var URLEncoded:String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789="
        let unreservedCharsSet: CharacterSet = CharacterSet(charactersIn: unreservedChars)
        let encodedString = self.addingPercentEncoding(withAllowedCharacters: unreservedCharsSet)!
        return encodedString
    }
    
    func stringToRGBToHex()-> String {
        return self.stringToRGBA()?.toHexString() ?? ""
    }
    
    func CGFloatValue() -> CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        
        return CGFloat(doubleValue)
    }
    var isBackspace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
}
extension Float
{
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var cleanTwoValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.f", self) : String(format: "%.2f", self)
    }
    func toDouble() -> Double? {
        return Double(self)
    }
    
    func toInt() -> Int? {
        if self > Float(Int.min) && self < Float(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
    
}
extension Date{
    
    //Convert Date to String
    func convertDateToString(strDateFormate:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormate
        let strDate = dateFormatter.string(from: self)
        //      dateFormatter = nil
        return strDate
    }
    
}


