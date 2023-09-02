//
//  EndPoint+RemoveImageFromDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation
enum Remove_image_from_deck_API: String {
    case removeImageFromDeck = "deck_shot"
}

extension Endpoints {
    
    static func getRequestURL(api: Remove_image_from_deck_API,deckID:String?,imageID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")" + "/\(imageID ?? "")")
    }
    
    static func getHTTPMethod(api: Remove_image_from_deck_API) -> String {
        switch api {
        case .removeImageFromDeck :
            return HttpMethod.DELETE.rawValue
        }
    }
}
