//
//  Endpoints+SearchSuggestion.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 09/01/23.
//

import Foundation
enum SEARCH_SUGGESTION_API: String {
    case search = "search"
}

extension Endpoints {
    
    static func getRequestURL(api: SEARCH_SUGGESTION_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: SEARCH_SUGGESTION_API) -> String {
        switch api {
        case .search :
            return HttpMethod.GET.rawValue
        }
    }
    
}
