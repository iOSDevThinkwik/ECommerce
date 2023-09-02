//
//  EndPoints+ExportDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/11/22.
//

import Foundation

enum EXPORT_DECK_API: String {
    case exportDeck = "export"
}

extension Endpoints {
    
    static func getRequestURL(api: EXPORT_DECK_API,deckID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(deckID ?? "")")
    }
    
    static func getHTTPMethod(api: EXPORT_DECK_API) -> String {
        switch api {
        case .exportDeck :
            return HttpMethod.GET.rawValue
        }
    }
    
}
