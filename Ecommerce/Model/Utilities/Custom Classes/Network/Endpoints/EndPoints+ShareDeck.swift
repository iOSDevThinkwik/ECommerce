//
//  EndPoints+ShareDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/11/22.
//

import Foundation

enum SHARE_DECK_API: String {
    case shareDeck = "share"
}

extension Endpoints {
    
    static func getRequestURL(api: SHARE_DECK_API,deckID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")")
    }
    
    static func getHTTPMethod(api: SHARE_DECK_API) -> String {
        switch api {
        case .shareDeck :
            return HttpMethod.POST.rawValue
        }
    }
    
}
