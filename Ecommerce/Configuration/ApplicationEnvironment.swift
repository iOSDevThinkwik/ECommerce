//  ApplicationEnvironment.swift
//  ShotDeck
//  Created by HEMANG SOLANKI  on 27/12/21.

import Foundation

enum ApplicationEnvironment: String{
    
    case developement,staging,production,debug
    
    static var current: ApplicationEnvironment {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
            guard let environmentName = nsDictionary?.object(forKey: "ApplicationEnvironment") as? String else {fatalError("Unknown AppEnvironment")}
            let environment = ApplicationEnvironment(rawValue: "staging")
//            let environment = ApplicationEnvironment(rawValue: environmentName)
            print("--------Current Environment--------\n", environment!)
            return environment!
        }
        else {
            print("--------Current Environment--------\n", "production")
            return ApplicationEnvironment.init(rawValue: "production")!
        }
        print("--------Current Environment--------\n", "production")
        return ApplicationEnvironment.init(rawValue: "production")!
    }
    
}
