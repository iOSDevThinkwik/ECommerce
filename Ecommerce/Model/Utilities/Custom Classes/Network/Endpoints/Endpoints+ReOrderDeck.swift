//
//  Endpoints+ReOrderDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/12/22.
//

import Foundation

enum REORDER_API: String {
    case Decks_order = "decks_order"
}

extension Endpoints {
    
    static func getRequestURL(api: REORDER_API,deckID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")")
    }
    
    static func getHTTPMethod(api: REORDER_API) -> String {
        switch api {
        case .Decks_order :
            return HttpMethod.PUT.rawValue
        }
    }
    
}
