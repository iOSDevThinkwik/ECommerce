//
//  CustomNavigationClass.swift
//  Shotdeck
//
//  Created by Shotdeck_Developer on 11/10/22.
//

import Foundation
import UIKit

class CustomNavigationConstraints: NSLayoutConstraint {
    
    override func awakeFromNib() {
        if hasTopNotch == true {
            self.constant = self.constant + 24
        }else{
            self.constant = self.constant + 7
        }
    }
    
}

var hasTopNotch: Bool {
    
    if #available(iOS 11.0, tvOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
    
}
