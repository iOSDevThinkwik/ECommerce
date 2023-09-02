//
//  RequestBuilder+GetExistingDeckList.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 22/11/22.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: Get_Add_To_deck_Existing_List_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .GetAddTodeckExistingList:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest,includeAuth: true,parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
}
