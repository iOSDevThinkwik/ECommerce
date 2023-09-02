//
//  EndPoints+AddImagesToDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/11/22.
//

import Foundation
enum ADD_IMAGES_DECK_API: String {
    case addImageToDeck = "deck_shot"
}

extension Endpoints {
    
    static func getRequestURL(api: ADD_IMAGES_DECK_API,deckID:String?,imageID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")" + "/\(imageID ?? "")")
    }
    
    static func getHTTPMethod(api: ADD_IMAGES_DECK_API) -> String {
        switch api {
        case .addImageToDeck :
            return HttpMethod.POST.rawValue
        }
    }
}
