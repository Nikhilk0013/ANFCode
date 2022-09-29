//
//  DownloadManager.swift
//  ANF Code Test
//
//  Created by Nikhil on 29/09/22.
//

import Foundation

final class DownloadManager {
    
    //MARK: - Shared Instance
    static let shared = DownloadManager()
    
    
    //MARK: - Initializers
    private init () { }
    
    //MARK: - Download Image
    func downloadImageData(from url: URL, completion: @escaping (_ data: Data?) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
            
        }.resume()
    }
}
