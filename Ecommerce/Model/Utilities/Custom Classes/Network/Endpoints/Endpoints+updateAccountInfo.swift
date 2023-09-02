//
//  Endpoints+updateAccountInfo.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 24/11/22.
//

import Foundation

enum UPDATE_PROFILE_API: String {
    case UpdateAccount = "account"
 
}

extension Endpoints {
    
    static func getRequestURL(api: UPDATE_PROFILE_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: UPDATE_PROFILE_API) -> String {
        switch api {
        case .UpdateAccount:
            return HttpMethod.PUT.rawValue
        }
    }
}
