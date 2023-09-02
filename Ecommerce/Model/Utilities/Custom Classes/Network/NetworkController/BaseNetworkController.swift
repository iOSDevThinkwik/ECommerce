//
//  BaseNetworkController.swift
//  fenix
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

public class BaseNetworkController {
    
    /// this operationQueue will have one instance all the time. hence declared as static
    private static let operationQueue = NetworkOperationQueue()
    
    init() {
        
    }
    
    internal func addOperation(request: URLRequest, jsonPath: JsonFileManager.JSONFile = .none, completion: @escaping (Data?, URLResponse?, ResponseStatus) -> Void) -> BaseOperation {
        let operation = NetworkOperation()
        operation.sessionRequest = request
        operation.completion = completion
        BaseNetworkController.operationQueue.addOperation(operation)
        return operation
    }
    
    internal static func setMinimumConcurrentOperationCount() {
        setConncurrentOperationCount(count: 50)
    }
    
    internal static func setDefaultConcurrentOperationCount() {
        setConncurrentOperationCount(count: 50)
    }
    
    private static func setConncurrentOperationCount(count: Int) {
        if count != operationQueue.maxConcurrentOperationCount {
            operationQueue.maxConcurrentOperationCount = count
        }
    }
    
    internal static func decodeArrayData<T: Codable>(data: Data) -> [T]? {
        do {
            let decodedData = try JSONDecoder().decode(Array<T>.self, from: data)
            return decodedData
        }
        catch {
            print("Error : ", error)
        }
        return nil
    }
    
    internal static func decodeData<T: Codable>(data: Data) -> T? {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        }
        catch {
            print(("Error : ", error))
        }
        return nil
    }
    
    internal static func encodeData<T: Encodable>(_ value: T) -> Data {
        var jsonData = Data()
        do {
            let jsonEncoder = JSONEncoder()
            jsonData = try jsonEncoder.encode(value)
        }
        catch {
            print("Error : ", error)
        }
        return jsonData
    }
    
    
    internal static func encodeBodyURLEncodedEnabledData<T: Encodable>(_ value: T) -> Data {
        let dictionary = value.dictionary
        var strBodyURLEncoded = ""
        
        for key in (dictionary?.keys)! {
            if let value = dictionary?[key] as? Bool {
                strBodyURLEncoded = strBodyURLEncoded + key + "=" + ((value == true) ? "true" : "false") + "&"
            }
            else {
                strBodyURLEncoded = strBodyURLEncoded + key + "=" + (dictionary?[key] as! String) + "&"
            }
        }
        
        if strBodyURLEncoded.count > 0 {
            strBodyURLEncoded.removeLast()
        }
        
        print("Parameters : ", strBodyURLEncoded)
        return strBodyURLEncoded.data(using: .utf8)!
    }
    
    internal static func encodeBodyURLEncodedEnabledDictionary(_ value: Dictionary<String, Any>) -> Data {
        let dictionary = value
        var strBodyURLEncoded = ""
        let keys = dictionary.keys.sorted(by: {$0.localizedStandardCompare($1) == .orderedAscending})
        for key in keys {
            if let value = dictionary[key] as? Bool {
                strBodyURLEncoded = strBodyURLEncoded + key + "=" + ((value == true) ? "true" : "false") + "&"
            }
            else {
                strBodyURLEncoded = strBodyURLEncoded + key + "=" + (dictionary[key] as! String) + "&"
            }
        }
        if strBodyURLEncoded.count > 0 {
            strBodyURLEncoded.removeLast()
        }
        print("Parameters : ", strBodyURLEncoded)
        return strBodyURLEncoded.data(using: .utf8)!
    }
    
}
