//
//  Endpoints+RenameDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation

enum Rename_Deck_API: String {
    case Renamedecks = "decks"
}

extension Endpoints {
    
    static func getRequestURL(api: Rename_Deck_API,deckID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "\(deckID ?? "")")
    }
    
    static func getHTTPMethod(api: Rename_Deck_API) -> String {
        switch api {
        case .Renamedecks :
            return HttpMethod.PUT.rawValue
        }
    }
}
