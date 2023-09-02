//
//  AppDelegate.swift
//  Ecommerce
//
//  Created by Thinkwik 27 on 02/09/23.
//

import UIKit
import IQKeyboardManagerSwift
import AppTrackingTransparency
import CoreData
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLoggedin = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configApp()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: *** Configuration ***
    
    private func configApp(){
        
        UIApplication.shared.statusBarStyle = .lightContent
        IQKeyboardManager.shared.enable = true
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 11)!], for: UIControl.State.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 11)!], for: UIControl.State.selected)
        UITabBar.appearance().tintColor = ColorConstants.BlueThemeColor
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.requestPermission()
        }
        if UserDefaults.standard.isUserLoggedIn() == true {
            //            DispatchQueue.main.async {
            //                let vc: TabbarVC = StoryBoardConstants.HOME.instantiateViewController(aClass: TabbarVC.self)
            //                let navVC = UINavigationController.init(rootViewController: vc)
            //                self.window?.rootViewController = navVC
            //                self.window?.makeKeyAndVisible()
            //            }
        }
    }
    
    //MARK: *** App Tracking ***
    //NEWLY ADDED PERMISSIONS FOR iOS 14 for App tracking
    
    func requestPermission() {
        if #available(iOS 15, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .authorized:
                    print("App Tracking Authorized")
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    print("App Tracking Denied")
                case .notDetermined:
                    print("App Tracking Not Determined")
                case .restricted:
                    print("App Tracking Restricted")
                @unknown default:
                    print("App Tracking Unknown")
                }
            }
        }
    }

}

