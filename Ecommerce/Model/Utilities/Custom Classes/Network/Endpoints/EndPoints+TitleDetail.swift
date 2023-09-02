//
//  EndPoints+TitleDetail.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 23/11/22.
//

import Foundation

enum TITLE_API: String {
    case Title = "titles"
}

extension Endpoints {
    
    static func getRequestURL(api: TITLE_API,titleID:String?) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue + "/\(titleID ?? "")")
    }
    
    static func getHTTPMethod(api: TITLE_API) -> String {
        switch api {
        case .Title :
            return HttpMethod.GET.rawValue
        }
    }
    
}
