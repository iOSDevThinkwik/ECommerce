//
//  RequestBuilder+AddImagesToDeck.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: ADD_IMAGES_DECK_API,deckID:String?,imageID:String?) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api, deckID: deckID,imageID: imageID) else {
            print("Unable to get request URL")
            return nil
        }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .addImageToDeck:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, includeAuth: true, parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
    
}
