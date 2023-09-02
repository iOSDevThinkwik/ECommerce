//
//  NetworkOperation.swift
//  NSUrlSession+RequestBuilder
//
//  Created by HEMANG SOLANKI  on 16/12/21.

import Foundation
import UIKit

class NetworkOperation : BaseOperation {
    
    private var startTime = Date()
    private static var retryCount: Int  = 0
    private static let retryMaxLimit: Int  = 2
    
    let responseStatus = ResponseStatus()
    
    let expiryTimeDelta: TimeInterval  = 200 // 10 mins
    
    override init() {
        super.init()
        //Added below to listen to .UIApplicationDidEnterBackground Notification to cancel any ongoing url session task since app going to background.
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    deinit {
        print("Operation Class Deinitialized: " + self.debugDescription)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appMovedToBackground() {
        print("App goes background so cancel the ongoing url session tasks")
        //invalidate the session by cancelling all tasks
        urlSession?.invalidateAndCancel()
    }
    
    private func makeErrorStatusResponse(message: String, errorCode: InAppErrorCodes) {
        responseStatus.errorMessage = message
        responseStatus.errorCode = errorCode.rawValue
    }
    
    override func execute() {
        guard let sessionRequest = sessionRequest else { return }
        startTime = Date()
        guard (sessionRequest.url?.absoluteString) != nil else {
            makeErrorStatusResponse(message: "Invalid Request URL.", errorCode: InAppErrorCodes.invalildRequest)
            print(responseStatus.errorMessage)
            self.completion?(nil, nil, responseStatus)
            finish()
            return
        }
        sendRequest(sessionRequest: sessionRequest)
    }
        
    private func sendRequest(sessionRequest: URLRequest) {
        print("Request Sent ..." + (sessionRequest.url?.absoluteString ?? ""))
        task = urlSession?.dataTask(with: sessionRequest, completionHandler: { [self](data, response, error) in
            //Added below to compute the total duration for network call and print it in log
            let time = Date().timeIntervalSince(self.startTime)
            if let jsonData = data {
                if responseStatus.errorCode == 400 {
//                    Common.shared.trialEndsView()
                }
                else {
                    self.completion?(jsonData, response, self.getResponseStatus(data: jsonData, request: sessionRequest ,response: response, error: error))
                }
            } else {
                self.completion?(nil, response, self.getResponseStatus(data: nil, request: sessionRequest, response: response, error: error))
            }
            self.finish()
        })
        task?.resume()
    }
    
    private func getResponseStatus(data: Data?, request: URLRequest, response: URLResponse?, error: Error?) -> ResponseStatus {
        let responseStatus = ResponseStatus(data: data, response: response, error: error)
        let jsonData = JsonFileManager.getJSONData(data: data)
        logConsoleRequestResponse(data: jsonData, request: request, response: response, responseStatus: responseStatus)
        return responseStatus
    }
        
    private func logConsoleRequestResponse(data: AnyObject?, request: URLRequest, response: URLResponse?, responseStatus: ResponseStatus) {
        
        var requestString = "\n-----------------------------------------------------\nRequest URL = " + (request.url?.absoluteString ?? "")
        requestString += "\nRequest Method = " + (request.httpMethod ?? "")
        requestString += "\nRequest Headers = " + "\(request.allHTTPHeaderFields!)"
        
        if let body = request.httpBody, let str = String(data: body, encoding: String.Encoding.utf8) {
            requestString += String(format: "\nRequest Body = %@",str)
        } else {
            requestString += "\nRequest Body = "
        }
        
        requestString += "\n**************************************************"
        
        var statusCode = 0
        if let response = response as? HTTPURLResponse {
            statusCode = response.statusCode
            requestString +=  "\nResponse Status Code = \(statusCode)"
            
            requestString += "\nResponse headers = " + "\(response.allHeaderFields)"
            //Added below to log response of dictionary or array type
            if let data = data as? [String : AnyObject] {
                requestString += String(format: "\nResponse Dictionary Body = %@", data)
            } else if let data = data as? [Any] {
                requestString += String(format: "\nResponse Array Body = %@", data)
            } else {
                requestString += "\nResponse Body = Not available"
            }
        }
        requestString += "\nRespopnse Error Message = " + responseStatus.errorMessage
        requestString += "\n-----------------------------------------------------\n"
        print(requestString)
    }
    
}



public class JsonFileManager {

    // Mock JSON Files
    public enum JSONFile : String {
        case none = "none"
        case login = "Login"
    }
    
    // MARK: - Static Methods
    public static func getFileData(filePath: JSONFile, fileExtension: String = "json") -> Data? {
        let bundle =  Bundle(for: BaseNetworkController.self)
        if let bundlePath = bundle.url(forResource: filePath.rawValue, withExtension: fileExtension) {
            do {
                let data = try Data(contentsOf: bundlePath, options: .alwaysMapped)
                return data
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
    
    public static func getJSONData(data: Data?) -> AnyObject? {
        
        if let data = data {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
