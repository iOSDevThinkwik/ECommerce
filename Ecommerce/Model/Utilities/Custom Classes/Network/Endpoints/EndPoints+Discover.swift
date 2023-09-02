//
//  EndPoints+Discover.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 28/11/22.
//

import Foundation

enum DISCOVER_API: String {
    case Discover = "discover"
 
}

extension Endpoints {
    
    static func getRequestURL(api: DISCOVER_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: DISCOVER_API) -> String {
        switch api {
        case .Discover:
            return HttpMethod.GET.rawValue
        }
    }
}
