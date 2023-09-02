//
//  ResponseStatus.swift
//  NSUrlSession+RequestBuilder
//
//  Created by shotDeck_developer  on 16/12/21.
//

import Foundation

public enum InAppErrorCodes: Int {
    case unhandledException = -9176344
    case sessionExpired     = -9176345
    case invalildRequest    = -9176346
    case noNetworkConnection = -9176347
    case connectionTimeout = -9176348
    case cancelled = -9176349
    case noServerConnection = -9176350
    case networkConnectionLost = -9176351
}

public struct ResponseData: Codable {
    let data: String?
}

public class ResponseStatus {
    
    public internal(set) var errorMessage: String = "We're experiencing a temporary issue with our servers. Please try again soon."
    public internal(set) var errorCode: Int = 0
    public internal(set) var statusCode: Int = 0
    public internal(set) var error: Error?
    
    public var description: String {
        let errorString = (error != nil) ? error.debugDescription : ""
        return ("Response: \n Status Code: \(statusCode) \n Error Code: \(errorCode) \n Message: "  + errorMessage + "\n Error: " + errorString)
    }

    public var isSuccess: Bool {
        return statusCode == HttpStatusCode.CODE_200.rawValue && errorCode == 0
    }
    
    init() {
        
    }
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.error = error
        if let response = response {
            if let httpResponse = response as? HTTPURLResponse {
                self.statusCode = httpResponse.statusCode
            }
        }

        if let error = error {
            self.errorMessage = error.localizedDescription
            self.errorCode = InAppErrorCodes.sessionExpired.rawValue
        } else if let data = data {
            do {
                let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                self.errorMessage = Utils.getValue(value: responseData.data, defaultValue: "")
            }
            catch {
                self.errorMessage = ""
            }
        }
        
        if Utils.getValue(value: self.errorMessage.contains("The request timed out."), defaultValue: false)  {
            self.errorCode = InAppErrorCodes.connectionTimeout.rawValue
        }
        
        if Utils.getValue(value: self.errorMessage.contains("cancelled"), defaultValue: false)  {
            self.errorCode = InAppErrorCodes.cancelled.rawValue
        }
        
        if Utils.getValue(value: self.errorMessage.contains("The Internet connection appears to be offline."), defaultValue: false)  {
            self.errorCode = InAppErrorCodes.noNetworkConnection.rawValue
        }
        
        if Utils.getValue(value: self.errorMessage.contains("expired timestamp"), defaultValue: false)  {
            self.errorCode = InAppErrorCodes.sessionExpired.rawValue
        }
        
        if Utils.getValue(value: self.errorMessage.contains("Could not connect to the server"), defaultValue: false)  {
            self.errorCode = InAppErrorCodes.noServerConnection.rawValue
        }

        if Utils.getValue(value: self.errorMessage.contains("The network connection was lost"), defaultValue: false)  {
            self.errorCode = InAppErrorCodes.networkConnectionLost.rawValue
        }
    }
    
    init(errorMessage: String, errorCode: Int, httpStatusCode: Int) {
        self.errorMessage = errorMessage
        self.errorCode = errorCode
        self.statusCode = httpStatusCode
    }
    
}

public class Utils {
    public static func getValue<T>(value: T? , defaultValue:T) -> T {
        if let expectedValue = value {
            return expectedValue
        }
        return defaultValue
    }
}
