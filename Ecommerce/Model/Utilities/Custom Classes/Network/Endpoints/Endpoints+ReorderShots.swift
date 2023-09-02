//
//  Endpoints+ReorderShots.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 16/03/23.
//

import Foundation
enum DECK_SHOTS_REORDER: String {
    case Deck_shots_order = "deck_shots_order"
}

extension Endpoints {
    
    static func getRequestURL(api: DECK_SHOTS_REORDER,deckID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")")
    }
    
    static func getHTTPMethod(api: DECK_SHOTS_REORDER) -> String {
        switch api {
        case .Deck_shots_order :
            return HttpMethod.PUT.rawValue
        }
    }
    
}
