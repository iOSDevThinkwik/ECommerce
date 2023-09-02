//
//  Endpoints+TitleSearch.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 09/01/23.
//

import Foundation
enum TITLE_SEARCH_API: String {
    case TitleSearch = "search_titles"
}

extension Endpoints {
    
    static func getRequestURL(api: TITLE_SEARCH_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: TITLE_SEARCH_API) -> String {
        switch api {
        case .TitleSearch :
            return HttpMethod.GET.rawValue
        }
    }
    
}
