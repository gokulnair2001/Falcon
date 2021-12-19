//
//  HttpClient.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import Foundation
import CoreMedia

public class HTTPUtility {
    
    static let shared = HTTPUtility()
    
    //MARK: - POST Request
    
    func postData(url: String, parameters: Any,completionHandler:@escaping(Result<Data, HttpErrors>)-> Void) {
        
        guard let serviceUrl = URL(string: url) else { return }
        
        let parameters = parameters
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("connect.sid=s%3AIU6ANwMf5pnnh1GKcykCcX0jBQDgQV85.Q%2By%2BbYXaS%2BJn7fOPe8bJy%2FxonlN6yXy25sA%2FmRy%2BLbo", forHTTPHeaderField: "Cookie")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {return}
            if let data = data {
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(.success(data))
                } catch {
                    completionHandler(.failure(HttpErrors(withServerResponse: data, forRequestUrl: request.url!, withHttpBody: request.httpBody, errorMessage: error.localizedDescription, forStatusCode: response.statusCode)))
                    print(error)
                }
            }
        }.resume()
    }
    
    //MARK: - GET Data
    func getData(url: String, completionHandler:@escaping(Result<HttpResults, HttpErrors>)-> Void) {
        
        guard let serviceUrl = URL(string: url) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if let data = data {
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(.success(HttpResults(withServerResponse: data, forStatusCode: response.statusCode, errorMessage: HttpResponseCode.code(code: response.statusCode))))
                    
                } catch {
                    completionHandler(.failure(HttpErrors(withServerResponse: data, forRequestUrl: request.url!, withHttpBody: request.httpBody, errorMessage: error.localizedDescription, forStatusCode: response.statusCode)))
                    print(error)
                }
            }
        }.resume()
    }
}
