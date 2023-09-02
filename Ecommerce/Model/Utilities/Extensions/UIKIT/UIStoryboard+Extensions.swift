//
//  UIStoryboard+Extensions.swift
//  CardSafe
//
//  Created by sarvatra on 10/10/22.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(aClass: UIViewController.Type) -> T {
        if isiPad() {
            print("iPad Detected..!!")
            let identifier = String(describing: aClass.self) + "_iPad"
            if let identifiersList = self.value(forKey: "identifierToNibNameMap") as? [String: Any] {
                if identifiersList[identifier] != nil {
                    return (self.instantiateViewController(identifier: String(describing: aClass.self) + "_iPad") as? T)!
                }
            }
        }
        print("iphone VC is returned..!!")
        let vc = self.instantiateViewController(identifier: String(describing: aClass.self))
        return vc as! T
    }
    
}
