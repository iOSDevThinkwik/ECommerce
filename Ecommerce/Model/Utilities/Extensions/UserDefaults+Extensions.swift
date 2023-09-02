//
//  UserDefaults+Extensions.swift
//  Shotdeck
//
//  Created by Shotdeck_Developer on 11/10/22.
//

import Foundation

enum UserDefaultsKey: String {
    
    case isFirstLaunch = "isFirstLaunch"
    case shouldShowTutorial = "shouldShowTutorial"
    case userInfo = "userInfo"
    case accessToken = "token"
    
    
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
    
}
