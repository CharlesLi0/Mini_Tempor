//
//  SummaryController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import UIKit

class SummaryController {
    
    //Singleton Pattern
    static let shared = SummaryController()
    
    let baseURL = URL(string: "https://quickchart.io")!
    
    //Get the image url
    func requestSummaryImage(forJsonString jsonString: String, completion: @escaping (URL) -> Void) {
        let requestURL = baseURL.appendingPathComponent("chart").appendingPathComponent("create")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, respinse, error) in
            if let data = data,
                let cast = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let url = cast["url"] as? String {
                completion(URL(string: url)!)
            } else {
                fatalError("Retrieved URL was not returned.")
            }
        }
        
        task.resume()
    } //end of requestSummaryImage
    
    //Get the image
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, respinse, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    } //end of fetchImage
}
