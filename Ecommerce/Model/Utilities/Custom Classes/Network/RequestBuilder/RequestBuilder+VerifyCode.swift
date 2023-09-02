//
//  RequestBuilder+VerifyCode.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation
extension RequestBuilder {
    
    func getRequestObject(api: Verify_Signuo_Code_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .signupVerify:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, parameterType: .QueryParam)!
            break;
        }
        return urlRequest
    }
}
