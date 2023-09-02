//
//  UserDefaults+Extensions.swift
//  Shotdeck
//
//  Created by HEMANG SOLANKI on 11/10/22.
//

import Foundation

enum UserDefaultsKey: String {
    
    case isFirstLaunch = "isFirstLaunch"
    case shouldShowTutorial = "shouldShowTutorial"
    case userInfo = "userInfo"
    case accessToken = "token"
    case appLanguage = "appLanguage"
    
    
}

extension UserDefaults {
    
    func isFirstLaunch() -> Bool {
        if self.object(forKey: UserDefaultsKey.isFirstLaunch.rawValue) == nil {
            return true
        }
        else {
            return self.object(forKey: UserDefaultsKey.isFirstLaunch.rawValue) as! Bool
        }
    }
    
    func setIsFirstLaunch() {
        self.set(false, forKey: UserDefaultsKey.isFirstLaunch.rawValue)
        self.synchronize()
    }
    
    func shouldShowTutorial() -> Bool {
        if self.object(forKey: UserDefaultsKey.shouldShowTutorial.rawValue) == nil {
            return true
        }
        return false
    }
    
    func setShouldShowTutorial() {
        self.setValue("1", forKey: UserDefaultsKey.shouldShowTutorial.rawValue)
        self.synchronize()
    }
    
    func setUserInfo(user: User) {
        do {
            let encodedUserInfo = try PropertyListEncoder().encode(user)
            self.set(encodedUserInfo, forKey: UserDefaultsKey.userInfo.rawValue)
            self.set(encodedUserInfo, forKey: "isUserDetail")
            self.synchronize()
        } catch {
            print("Userinfo not saved..")
        }
    }
    
    func getUserInfo() -> User? {
        if let data = UserDefaults.standard.value(forKey:UserDefaultsKey.userInfo.rawValue) as? Data {
            let user = try? PropertyListDecoder().decode(User.self, from: data)
            return user
        }
        return nil
    }
    
    func isUserLoggedIn() -> Bool {
        if self.accessToken != "" {
            return true
        }
        return false
    }
    
    var accessToken: String {
        set{
            self.setValue(newValue, forKey: UserDefaultsKey.accessToken.rawValue)
            self.synchronize()
        }
        get {
            return (self.value(forKey: UserDefaultsKey.accessToken.rawValue) as? String) ?? ""
        }
    }
    
    func setAppLanguage(langCode:String){
        self.setValue(langCode, forKey: UserDefaultsKey.appLanguage.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getAppLanguage() -> String{
        return self.value(forKey: UserDefaultsKey.appLanguage.rawValue) as? String ?? "en"
    }
    
    
    
    func removeAll() {
        UserDefaults.standard.removeObject(forKey:  "isUserDetail")
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userInfo.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.isFirstLaunch.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.shouldShowTutorial.rawValue)
        
        let domain = Bundle.main.bundleIdentifier!
        self.removePersistentDomain(forName: domain)
        self.synchronize()
    }
    
    
}
