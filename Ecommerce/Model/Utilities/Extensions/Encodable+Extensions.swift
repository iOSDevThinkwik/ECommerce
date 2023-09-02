//
//  Encodable+Extensions.swift
//  Fenix
//
//  Created by HEMANG SOLANKI  on 06/01/22.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var dictionaryFromObject: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}

extension Array where Element: Encodable {
    
    func asDictionaryFromArray() -> [[String: Any]] {
        var dict = [[String: Any]]()
        
        _ = self.map {
            if let objectDict = $0.dictionaryFromObject {
                dict.append(objectDict)
            }
        }
        
        return dict
    }
    
}
