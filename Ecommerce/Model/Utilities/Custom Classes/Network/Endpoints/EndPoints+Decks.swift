//
//  EndPoints+Decks.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation

enum Decks_API: String {
    case decks = "decks"
}

extension Endpoints {
    
    static func getRequestURL(api: Decks_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Decks_API) -> String {
        switch api {
        case .decks:
            return HttpMethod.GET.rawValue
        }
    }
    
}


