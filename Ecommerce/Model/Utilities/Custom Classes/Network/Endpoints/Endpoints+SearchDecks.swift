//
//  Endpoints+SearchDecks.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 14/12/22.
//

import Foundation
enum Search_Decks_API: String {
    case search_decks = "search_decks"
}

extension Endpoints {
    
    static func getRequestURL(api: Search_Decks_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Search_Decks_API) -> String {
        switch api {
        case .search_decks:
            return HttpMethod.GET.rawValue
        }
    }
    
}
