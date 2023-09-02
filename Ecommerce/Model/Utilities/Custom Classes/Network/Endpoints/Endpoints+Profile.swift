//
//  Endpoints+Profile.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 17/11/22.
//

import Foundation
enum Profile_API: String {
    case account = "account"
    case deleteToken = "login"
    case ChangePassword = "password"
}

extension Endpoints {
    
    static func getRequestURL(api: Profile_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Profile_API) -> String {
        switch api {
        case .deleteToken :
            return HttpMethod.DELETE.rawValue
        case .account :
            return HttpMethod.GET.rawValue
        case .ChangePassword:
            return HttpMethod.PUT.rawValue
        }
    }
}
