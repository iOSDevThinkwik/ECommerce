//
//  RequestBuilder+Move_ReOrderDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/03/23.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: REORDER_MOVE_API,deckID:String?,parentID:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api,deckID:deckID,parentID: parentID) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .Decks_Reorder_Move :
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true,parameterType: .bodyUrlEncoded)!
            break;
        }
        return urlRequest
    }
}
