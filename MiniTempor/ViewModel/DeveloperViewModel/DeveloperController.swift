//
//  DeveloperController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import UIKit

struct DeveloperController {
    
    //The app_id and app_ley required for using the Kairos API
    let app_id = "4717df08"
    let app_key = "9919ebb7d72ec95016cd75e4f9b7ee0a"
    let baseURL = URL(string: "https://api.kairos.com")!
    
    //Singleton Pattern
    static let shared = DeveloperController()
    
    private func convertImageToBase64String(_ image: UIImage) -> String {
        let imageData = image.pngData()?.base64EncodedString()
        return imageData!
    }
    
    public func enrollImage(image: UIImage, name: String, completion: @escaping (Bool) -> Void) {
        let enrollURL = baseURL.appendingPathComponent("enroll")
        
        var enrollRequest = URLRequest(url: enrollURL)
        enrollRequest.httpMethod = "POST"
        enrollRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        enrollRequest.addValue(app_id, forHTTPHeaderField: "app_id")
        enrollRequest.addValue(app_key, forHTTPHeaderField: "app_key")
        
        let jsonString = """
            {
                "image": "\(convertImageToBase64String(image))",
                "subject_id": "\(name)",
                "gallery_name": "iPhone SE Gallery"
            }
        """
        
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        
        enrollRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: enrollRequest) { (data, response, error) in
            if let data = data,
                let cast = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let first = cast.first,
                let string = String(data: data, encoding: .utf8) {
                print(string)
                if first.key == "face_id" {
                    completion(true)
                } else if first.key == "Errors" {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        
        task.resume()
    }
    
    public func recognizeImage(image: UIImage, completion: @escaping (Bool, String) -> Void) {
        let recognizeURL = baseURL.appendingPathComponent("recognize")
        
        var recognizeRequest = URLRequest(url: recognizeURL)
        recognizeRequest.httpMethod = "POST"
        recognizeRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        recognizeRequest.addValue(app_id, forHTTPHeaderField: "app_id")
        recognizeRequest.addValue(app_key, forHTTPHeaderField: "app_key")
        
        let jsonString = """
            {
                "image": "\(convertImageToBase64String(image))",
                "gallery_name": "iPhone SE Gallery"
            }
        """
        
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        
        recognizeRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: recognizeRequest) { (data, response, error) in
            if let data = data,
                let cast = try? JSONSerialization.jsonObject(with: data) as? [String: [[String: Any]]],
                let first = cast.first,
                let string = String(data: data, encoding: .utf8) {
                print(string)
                if first.key == "images" {
                    let transaction = first.value.first?["transaction"] as! [String: Any]
                    if let name = transaction["subject_id"] {
                        completion(true, name as! String)
                    } else {
                        completion(false, "")
                    }
                } else if first.key == "Errors" {
                    completion(false, "")
                }
            } else {
                completion(false, "")
            }
        }
        
        task.resume()
    }
}
