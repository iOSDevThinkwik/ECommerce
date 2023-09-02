//
//  EndPoints+DeckDetails.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation
enum DeckDetail_API: String {
    case deckDetail = "decks"
}

extension Endpoints {
    
    static func getRequestURL(api: DeckDetail_API,deckID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "\(deckID ?? "")")
    }
    
    static func getHTTPMethod(api: DeckDetail_API) -> String {
        switch api {
        case .deckDetail :
            return HttpMethod.GET.rawValue
        }
    }
}
