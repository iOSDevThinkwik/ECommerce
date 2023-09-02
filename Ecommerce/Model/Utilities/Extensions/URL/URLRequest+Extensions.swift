//
//  URLRequest+Extensions.swift
//  Fenix
//
//  Created by shotDeck_developer  on 06/01/22.
//

import Foundation

extension URLRequest{
    
    mutating func appendQueryParams<T: Codable>(queryPrams: T) -> URLRequest? {
        var urlCommonents = URLComponents.init(string: self.url!.absoluteString)
        var queryItems = [URLQueryItem]()
        
        let queryDic = queryPrams.dictionary
        for key in (queryDic?.keys)! {
            var queryValue = ""
            if let value = queryDic?[key] as? Bool {
                queryValue = ((value == true) ? "true" : "false")
            }
            else {
                queryValue = (queryDic![key] as! String)
            }
            let queryItem = URLQueryItem.init(name: key, value: queryValue)
            queryItems.append(queryItem)
        }
        if urlCommonents?.queryItems != nil {
            var requestQueryItems = urlCommonents?.queryItems
            requestQueryItems?.append(contentsOf: queryItems)
            urlCommonents?.queryItems = requestQueryItems
        }
        else {
            urlCommonents?.queryItems = queryItems
        }
        self.url = urlCommonents?.url
        return self
    }
    
    mutating func appendQueryParams(queryPrams: [String: Any]) -> URLRequest? {
        var urlCommonents = URLComponents.init(string: self.url!.absoluteString)
        var queryItems = [URLQueryItem]()
        for key in queryPrams.keys {
            var queryValue = ""
            if let value = queryPrams[key] as? Bool {
                queryValue = ((value == true) ? "true" : "false")
            }
            else {
                queryValue = (queryPrams[key] as! String)
            }
            let queryItem = URLQueryItem.init(name: key, value: queryValue)
            queryItems.append(queryItem)
        }
        
        if urlCommonents?.queryItems != nil {
            var requestQueryItems = urlCommonents?.queryItems
            requestQueryItems?.append(contentsOf: queryItems)
            urlCommonents?.queryItems = requestQueryItems
        }
        else {
            urlCommonents?.queryItems = queryItems
        }

        self.url = urlCommonents?.url
        return self
    }
}
