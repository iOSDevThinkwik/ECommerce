//
//  GlobalConstants.swift
//  Shotdeck
//
//  Created by HEMANG SOLANKI on 11/10/22.
//

import Foundation
import UIKit


//API Related Constats
let PLATFORM = "ios"



func presentFromAnywhere(vc : UIViewController){
    let window = UIWindow(frame: UIScreen.main.bounds)
    let dummyViewController = UIViewController()
    
    dummyViewController.view.backgroundColor = UIColor.clear
    window.rootViewController = dummyViewController
    
    window.windowLevel = UIWindow.Level.normal + 2
    window.backgroundColor = .clear
    dummyViewController.view.backgroundColor = .clear
    // Instructions doesn't use a key window, but the alert probably should.
    window.makeKeyAndVisible()
    
    dummyViewController.present(vc, animated: true, completion: nil)
}


struct ScreenSize{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//MARK: Iphone-X or Bigger
var isIphoneXOrBigger: Bool {
    // 812.0 on iPhone X, XS.
    // 896.0 on iPhone XS Max, XR.
    return UIScreen.main.bounds.height >= 812
}

//MARK: Ipad
func isiPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

func getHeightFrom(originalWidth: CGFloat, originalHeight: CGFloat, newWidth: CGFloat) -> CGFloat {
//    (original height / original width) x new width = new height
    return (originalHeight / originalWidth) * newWidth
}

func getWidthFrom(originalWidth: CGFloat, originalHeight: CGFloat, newHieght: CGFloat) -> CGFloat {
//    (original height / original width) x new width = new height
    return (originalWidth / originalHeight) * newHieght
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
