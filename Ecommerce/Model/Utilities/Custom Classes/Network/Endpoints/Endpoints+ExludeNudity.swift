//
//  Endpoints+ExludeNudity.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 10/03/23.
//

import Foundation
enum EXCLUDE_NUDITY_API: String {
    case nudity_filter = "nudity_filter"
}

extension Endpoints {
    
    static func getRequestURL(api: EXCLUDE_NUDITY_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: EXCLUDE_NUDITY_API) -> String {
        switch api {
        case .nudity_filter :
            return HttpMethod.PUT.rawValue
        }
    }
    
}
