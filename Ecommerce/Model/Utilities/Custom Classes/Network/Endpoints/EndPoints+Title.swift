//
//  EndPoints+Title.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 30/11/22.
//

import Foundation

enum TITLE_MAIN_API: String {
    case TitleMain = "titles"
}

extension Endpoints {
    
    static func getRequestURL(api: TITLE_MAIN_API) -> URL? {
        return URL(string: Endpoints.getBaseAppURL() + api.rawValue)
    }
    
    static func getHTTPMethod(api: TITLE_MAIN_API) -> String {
        switch api {
        case .TitleMain :
            return HttpMethod.GET.rawValue
        }
    }
    
}
