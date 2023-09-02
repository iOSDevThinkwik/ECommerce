//
//  Endpoints+addCaptionForImage.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/11/22.
//

import Foundation
enum ADD_CAPTION_TO_IMAGE_API: String {
    case addCaptionToDeck = "deck_shot"
}

extension Endpoints {
    
    static func getRequestURL(api: ADD_CAPTION_TO_IMAGE_API,deckID:String?,imageID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")" + "/\(imageID ?? "")")
    }
    
    static func getHTTPMethod(api: ADD_CAPTION_TO_IMAGE_API) -> String {
        switch api {
        case .addCaptionToDeck :
            return HttpMethod.PUT.rawValue
        }
    }
}
