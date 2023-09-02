//
//  EndPoints+ReorderMoveDecks.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 20/03/23.
//

import Foundation
enum REORDER_MOVE_API: String {
    case Decks_Reorder_Move = "decks_order"
}

extension Endpoints {
    
    static func getRequestURL(api: REORDER_MOVE_API,deckID:String?,parentID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")" + "/\(parentID ?? "")")
    }
    
    static func getHTTPMethod(api: REORDER_MOVE_API) -> String {
        switch api {
        case .Decks_Reorder_Move :
            return HttpMethod.PUT.rawValue
        }
    }
    
}
