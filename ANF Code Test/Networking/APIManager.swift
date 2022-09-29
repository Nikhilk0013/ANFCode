//
//  NetworkingManager.swift
//  ANF Code Test
//
//  Created by Nikhil on 28/09/22.
//

import Foundation

enum NetworkError: String, Error {
    case serverError = "Server Error"
}

final class APIManager {
    
    static let shared = APIManager()
    
    
    private init () { }
        
    
    func fetchAllProducts(completionHandler: @escaping (Result<[Product], NetworkError>) -> Void ) {
        
        guard let url = URL(string: AppConstants.Endpoint.FETCH_PRODUCTS)  else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(.serverError))
                return
            }
            
            do {
                
                let productsList = try JSONDecoder().decode([Product].self, from: data)
                completionHandler(.success(productsList))
                
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        })
        task.resume()
    }
    
}
