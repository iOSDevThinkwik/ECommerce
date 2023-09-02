//
//  SdWeb+Extension.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 16/11/22.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

let imageCache = NSCache<AnyObject, AnyObject>()
let duration = 0.75
extension UIImageView {
    
    func setImageForShot(id: String, size: String = imageSize.medium_thumb.rawValue, index: Int = -1, isAnimated: Bool = true, complition: ((UIImage?) -> Void)? ) {
//        DispatchQueue.main.async {
//            let spinner = UIActivityIndicatorView()
//            spinner.style = .medium
//            spinner.color = ColorConstants.BlueThemeColor
//            spinner.center = self.center
//            spinner.tag = -1131
//            spinner.startAnimating()
//        }
        if let img = self.getSavedImage(named: id) {
            DispatchQueue.main.async {
                if self.tag == index {
                    if isAnimated == true {
                        self.image = nil
                        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
                            self.image = img
                            self.hideSkeleton()
                        }
                    }
                    else {
                        self.image = img
                        self.hideSkeleton()
                    }
                    //spinner.stopAnimating()
                }
            }
            if let complition = complition {
                complition(img)
            }
        }
        else {
            self.image = nil
           // DispatchQueue.global(qos: .userInteractive).async {
                let url = Endpoints.getBaseAppURL() + "image" + id + "?size=" + imageSize.thumb.rawValue
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
                var request = URLRequest.init(url: URL(string: url)!)
                request.httpMethod = "GET"
                request.setValue(UserDefaults.standard.accessToken, forHTTPHeaderField: "X-AUTH-TOKEN")
                request.setValue(Endpoints.getAPIKey(), forHTTPHeaderField: "X-API-KEY")
                
                let tsk = session.dataTask(with: request) {
                    data, urlResponse, error in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        //complition!(nil)
                    }
                    else {
                        if let httpResponse = urlResponse as? HTTPURLResponse{
                            if httpResponse.statusCode == 402{
                                print("Refresh token...")
                                return
                            }
                        }
                        if let imageData = data {
                            if self.saveImage(data: imageData, fileName: id) == true {
                                let img = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    if self.tag == index {
                                        if isAnimated == true {
                                            self.image = nil
                                            UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) {
                                                self.image = img
                                                self.hideSkeleton()
                                            }
                                        }
                                        else {
                                            self.image = img
                                            self.hideSkeleton()
                                        }
                                    }
                                    //spinner.stopAnimating()
                                }
                                if let complition = complition {
                                    complition(img)
                                    self.hideSkeleton()
                                    //spinner.stopAnimating()
                                }
                                //self.hideSkeleton()
                            }
                            else {
                                complition!(nil)
                            }
                        }
                        //self.hideSkeleton()
                        //spinner.stopAnimating()
                    }
                }
                tsk.resume()
            }
        //}
    }
    
    func setImageForShotDetail(id: String, size: String = imageSize.medium_thumb.rawValue, index: Int = -1, isAnimated: Bool = true, complition: ((UIImage?) -> Void)? ) {
        if let img = self.getSavedImage(named: id) {
            DispatchQueue.main.async {
                if self.tag == index {
                    self.image = img
                    self.hideSkeleton()
                    //spinner.stopAnimating()
                }
            }
            if let complition = complition {
                complition(img)
            }
        }
        else {
            self.image = nil
           // DispatchQueue.global(qos: .userInteractive).async {
                let url = Endpoints.getBaseAppURL() + "image" + id + "?size=" + imageSize.thumb.rawValue
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
                var request = URLRequest.init(url: URL(string: url)!)
                request.httpMethod = "GET"
                request.setValue(UserDefaults.standard.accessToken, forHTTPHeaderField: "X-AUTH-TOKEN")
                request.setValue(Endpoints.getAPIKey(), forHTTPHeaderField: "X-API-KEY")
                
                let tsk = session.dataTask(with: request) {
                    data, urlResponse, error in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        //complition!(nil)
                    }
                    else {
                        if let httpResponse = urlResponse as? HTTPURLResponse{
                            if httpResponse.statusCode == 402{
                                print("Refresh token...")
                                return
                            }
                        }
                        if let imageData = data {
                            if self.saveImage(data: imageData, fileName: id) == true {
                                let img = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    if self.tag == index {
                                        self.image = img
                                        self.hideSkeleton()
                                    }
                                    //spinner.stopAnimating()
                                }
                                if let complition = complition {
                                    complition(img)
                                    self.hideSkeleton()
                                    //spinner.stopAnimating()
                                }
                                //self.hideSkeleton()
                            }
                            else {
                                complition!(nil)
                            }
                        }
                        //self.hideSkeleton()
                        //spinner.stopAnimating()
                    }
                }
                tsk.resume()
            }
        //}
    }
    
    private func getSavedImage(named: String) -> UIImage? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("imgs")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        let filePath = URL.init(fileURLWithPath: dataPath.appendingPathComponent(named + ".png").absoluteString)
        return UIImage(contentsOfFile: filePath.path)
    }
    
    private func saveImage(data: Data, fileName: String) -> Bool {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("imgs")
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        let filePath = URL.init(fileURLWithPath: dataPath.appendingPathComponent(fileName + ".png").absoluteString)
        do {
            try data.write(to: filePath)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
