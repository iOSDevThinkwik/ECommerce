//
//  RequestBuilder+Auth.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

extension RequestBuilder {
    
    func getRequestObject(api: Auth_API) throws -> URLRequest? {
        guard let url = Endpoints.getRequestURL(api: api) else {
            print("Unable to get request URL")
            return nil
        }
        
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = Endpoints.getHTTPMethod(api: api)
        switch api {
        case .login:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, parameterType: .bodyUrlEncoded)!
            break;
        case .signupAccount:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest,parameterType: .bodyUrlEncoded)!
            break;
        case .signup:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, parameterType: .bodyUrlEncoded)!
            break;
        case .forgotpassword:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, parameterType: .bodyUrlEncoded)!
            break;
        case .getJobCategory:
            urlRequest = RequestBuilder.appendHeaders(urlRequest: urlRequest, parameterType: .JSONParam)!
            break;
        }
        return urlRequest
    }
}
