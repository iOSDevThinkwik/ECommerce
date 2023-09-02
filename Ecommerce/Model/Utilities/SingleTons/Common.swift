//
//  Common.swift
//  Shotdeck
//
//  Created by shotDeck_developer  on 28/12/21.
//

import Foundation
import UIKit
import AVFoundation
import SDWebImage
import SVProgressHUD

class Common: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    static let shared = Common()
    
    typealias speedTestCompletionHandler = (_ megabytesPerSecond: Double? , _ error: Error?) -> Void
    var speedTestCompletionBlock : speedTestCompletionHandler?
    
    let APPDELEGATE = (UIApplication.shared.delegate as! AppDelegate)
    var startTime: CFAbsoluteTime!
    var stopTime: CFAbsoluteTime!
    var bytesReceived: Int!
    var session : URLSession?
    let New_PopUp_Frame = CGRect(x: 0, y:  0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    var activityView: UIActivityIndicatorView?
    
    func showHUD() {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(ColorConstants.BlueThemeColor!)
        SVProgressHUD.setBackgroundColor(ColorConstants.DarkGrayColor!)
        SVProgressHUD.show()
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
    }
    
    func openUrl(url: String) {
        UIApplication.shared.open(URL.init(string: url)!, options: [:], completionHandler: nil)
    }
    
    func shareContent(target: UIViewController, textToShare: String, url: String = "") {
        if let myWebsite = NSURL(string: url) {
            let objectsToShare: [Any] = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = target.view
            target.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func openShareOption(vc: UIViewController,link: String){
        let objectsToShare = [link]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        vc.present(activityVC, animated: true, completion: nil)
    }
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
//    func readLocalized(str : String)->String{
//        var languageType = "en"
//        //    if let requiredLanguage = UserDefaults.standard.value(forKey: LocalStoredData.APP_LANGUAGE.rawValue) as? String{
//        //        languageType = (requiredLanguage.trim().count > 0) ? requiredLanguage : "en"
//        //    }
//        //    let bpath:String = Bundle.main.path(forResource: languageType, ofType: "lproj")! as String
//        //    let bundle = Bundle(path: bpath as String)
//        //    return NSLocalizedString(str, bundle: bundle!, comment: "")
//
//        if let storedLanguage = UserDefaults.standard.object(forKey: UserDefaultsKey.appLanguage.rawValue) as? String{
//            languageType = storedLanguage
//        }
//        var bpath:String = Bundle.main.path(forResource: languageType, ofType: "lproj")! as String
//        var bundle = Bundle(path: bpath as String)
//        var strFinalString = NSLocalizedString(str, bundle: bundle!, comment: "")
//
//        //Loading English values if destined values is blank
//        if (strFinalString.trim().isEmpty || strFinalString == str ) && languageType != "en"{
//            bpath = Bundle.main.path(forResource: "en", ofType: "lproj")! as String
//            bundle = Bundle(path: bpath as String)
//            strFinalString = NSLocalizedString(str, bundle: bundle!, comment: "")
//        }
//        return strFinalString
//    }
    
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        bytesReceived! += data.count
        stopTime = CFAbsoluteTimeGetCurrent()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let elapsed = stopTime - startTime
        if let aTempError = error as NSError?, aTempError.domain != NSURLErrorDomain && aTempError.code != NSURLErrorTimedOut && elapsed == 0  {
            speedTestCompletionBlock?(nil, error)
            return
        }
        let speed = elapsed != 0 ? Double(bytesReceived) / elapsed / 1024.0 / 1024.0 : -1
        speedTestCompletionBlock?(speed, nil)
    }
    
    func logout() {
        UserDefaults.standard.removeAll()
        self.delay(0.3) {
            DispatchQueue.main.async { [self] in
//                let vc: FreeTrialVC = StoryBoardConstants.TABBAR.instantiateViewController(aClass: FreeTrialVC.self)
//                let navVC = UINavigationController.init(rootViewController: vc)
//                APPDELEGATE.window?.rootViewController = navVC
//                APPDELEGATE.window?.makeKeyAndVisible()
            }
        }
    }
    
    func trialEndsView(){
        DispatchQueue.main.async { [self] in
//            let vc: TrialEndsVC = StoryBoardConstants.TABBAR.instantiateViewController(aClass: TrialEndsVC.self)
//            let navVC = UINavigationController.init(rootViewController: vc)
//            APPDELEGATE.window?.rootViewController = navVC
//            APPDELEGATE.window?.makeKeyAndVisible()
        }
    }
    
    func cleanUp() {
//        UserDefaults.standard.removeChacheImages()
    }
    
    func buttonWithImageTint(btn:UIButton,image: UIImage,Uicolor:UIColor){
        btn.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.tintColor = Uicolor
        btn.tintColor = Uicolor
    }
    
    func removeView(view : UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha  = 0.0;
            APPMANAGER.layerBG?.alpha  = 0.0;
        }) { (completed) in
            view.removeFromSuperview()
        }
    }
    
}
struct NotificationKeys{
    static let DISMISS_TOUCH = "DISMISS_TOUCH_VC"
    static let RELOAD_DATA = "RELOAD_DATA"
    static let SKIP_PRESSED = "SKIP_PRESSED"
    static let RELOAD_BROWSE = "RELOAD_BROWSE"
    static let DISMISS_VIEW = "DISMISS_VIEW"
    static let REFRESH_VIEW = "REFRESH_VIEW"
    static let QUICK_ADD_NAME = "QUICK_ADD_NAME"
    static let SEARCH_DISMISS = "SEARCH_DISMISS"
    static let RELOAD_COLLECTIONVIEW = "RELOAD_COLLECTIONVIEW"
    static let LAYOUT_RELOAD = "LAYOUT_RELOAD"
    static let SIZE_CHANGE = "SIZE_CHANGE"
    static let SHOTS_Filter = "SHOTS_Filter"
    static let SHOW_PRIMARYVIEW = "SHOW_PRIMARYVIEW"
    static let HIDE_PRIMARYVIEW = "HIDE_PRIMARYVIEW"
    static let SHOW_PRIMARYVIEW_TITLES = "SHOW_PRIMARYVIEW_TITLES"
    static let HIDE_PRIMARYVIEW_TITLES = "HIDE_PRIMARYVIEW_TITLES"
    static let TITLES_Filter = "TITLES_Filter"
    static let TITLES_VIEW_LIST = "TITLES_VIEW_LIST"
    static let TITLES_VIEW_PHOTO = "TITLES_VIEW_PHOTO"
    static let SHOW_SHOT_FILTER = "SHOW_SHOT_FILTER"
    static let HIDE_SHOT_FILTER = "HIDE_SHOT_FILTER"
    static let SHOW_TITLE_FILTER = "SHOW_TITLE_FILTER"
    static let HIDE_TITLE_FILTER = "HIDE_TITLE_FILTER"
    static let SHOT_VIEW_RELOAD = "SHOT_VIEW_RELOAD"
    static let TITLE_VIEW_RELOAD = "TITLE_VIEW_RELOAD"
    static let HIDE_MENU = "HIDE_MENU"
    static let RELOAD_DISCOVER = "RELOAD_DISCOVER"
    static let RELOAD_SHOT_TYPE = "RELOAD_SHOT_TYPE"
    static let DECK_Filter = "DECK_Filter"
    static let DISCOVER_RELOAD = "DISCOVER_RELOAD"
    
}

extension AVPlayer {
    
    var isPlaying: Bool {
        if (self.rate != 0 && self.error == nil) {
            return true
        } else {
            return false
        }
    }
    
}

class AppManager {
    
    var layerBG : UIView?
    
    func currentAppVersion() -> String{
        let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return appVersionString
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func removeView(view : UIView){
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha  = 0.0;
            self.layerBG?.alpha  = 0.0;
        }) { (completed) in
            view.removeFromSuperview()
        }
    }
    func setUpLayer(){
        if layerBG == nil{
            layerBG = UIView(frame: UIScreen.main.bounds)
            layerBG?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        layerBG?.alpha = 0.7;
    }
    
    
    
}
let APPMANAGER = AppManager.init()


// MARK:- DEVICE TYPE
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_5_OR_LESS       = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH <= 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6_PLUS     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_6_OR_LESS   = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH <= 667.0
    static let IS_IPHONE_MINI     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_13_OR_13_PRO     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 844.0
    static let IS_IPHONE_13_PRO_MAX     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 926.0
    static let IS_IPHONE_XS_MAX     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
}


//func isInternetReachable()->Bool{
//    return Reachability.isConnectedToNetwork()
//}

