//
//  Endpoints+TitleFilters.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 10/05/23.
//

import Foundation

enum GET_TITLE_FILTER_API: String {
    case title_filterAPI = "title_filters"
    case title_filterCount = "titles_total"
}

extension Endpoints {
    
    static func getRequestURL(api: GET_TITLE_FILTER_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: GET_TITLE_FILTER_API) -> String {
        switch api {
        case .title_filterAPI, .title_filterCount :
            return HttpMethod.GET.rawValue
        }
    }
    
}
