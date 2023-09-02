//
//  Endpoints+Browse.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 15/11/22.
//

import Foundation

enum Browse_API: String {
    case browseShot = "images"
    case browseImage = "image"
    case browseMoreImages = "more_images"
}
extension Endpoints {
    
    static func getRequestURL(api: Browse_API, imageID:String?) -> URL? {
        let urlString = (Endpoints.getBaseAppURL() + api.rawValue + "\(imageID ?? "")").addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        return  url
    }
    
    static func getHTTPMethod(api: Browse_API) -> String {
        switch api {
        case .browseShot, .browseImage, .browseMoreImages :
            return HttpMethod.GET.rawValue
        }
    }
    
}
