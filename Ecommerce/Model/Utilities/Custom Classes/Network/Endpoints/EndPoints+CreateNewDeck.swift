//  EndPoints+CreateNewDeck.swift
//  SHOTDECK
//  Created by Shotdeck_developer on 21/11/22.

import Foundation

enum Create_New_Deck_API: String {
    case CreateNewDeck = "decks"
}

extension Endpoints {
    
    static func getRequestURL(api: Create_New_Deck_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: Create_New_Deck_API) -> String {
        switch api {
        case .CreateNewDeck :
            return HttpMethod.POST.rawValue
        }
    }

}
