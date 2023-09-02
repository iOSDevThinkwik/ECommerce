//
//  Endpoints+WhereToStream.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 02/01/23.
//

import Foundation

enum STREAMING_API: String {
    case Streaming_Options = "streaming_options"
}

extension Endpoints {
    
    static func getRequestURL(api: STREAMING_API,titleID:String?, countryCode:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(titleID ?? "")" + "/\(countryCode ?? "")")
    }
    
    static func getHTTPMethod(api: STREAMING_API) -> String {
        switch api {
        case .Streaming_Options :
            return HttpMethod.GET.rawValue
        }
    }
    
}
