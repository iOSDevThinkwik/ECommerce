//
//  Endpoints+Filters.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/11/22.
//

import Foundation

enum GET_FILTER_API: String {
    case filterAPI = "filters"
    case filterCount = "images_total"
}

extension Endpoints {
    
    static func getRequestURL(api: GET_FILTER_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: GET_FILTER_API) -> String {
        switch api {
        case .filterAPI, .filterCount :
            return HttpMethod.GET.rawValue
        }
    }
    
}
