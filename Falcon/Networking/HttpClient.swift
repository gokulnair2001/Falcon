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
    
    func postData(url: String, parameters: Any, completionHandler:@escaping(Result<HttpResults, HttpErrors>)-> Void) {
        
        guard let serviceUrl = URL(string: url) else {
            print("💥💥💥💥💥💥💥v")
            return }
        
        /// To get Response Time of Request sent
        var timeTaken: TimeInterval = 0
        serviceUrl.responseTime { (time) in
            if let responseTime = time {
                timeTaken = responseTime
            }
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtZXNzYWdlIjoiaGVja2VyIiwiaWF0IjoxNjMyMjA0MjcyfQ.QetSTqHMjmLSZDWFcGidwdjPHD1rbiCdCXP_X_pDPcw", forHTTPHeaderField: "auth-token")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                print("💥")
                return}
            if let data = data {
                do {
                    print("💥💥")
                    let _ = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(.success(HttpResults(withServerResponse: data, forStatusCode: response.statusCode, errorMessage: HttpResponseCode.code(code: response.statusCode), responseTime: timeTaken)))
                } catch {
                    print("💥💥💥💥")
                    completionHandler(.failure(HttpErrors(withServerResponse: data, forRequestUrl: request.url!, withHttpBody: request.httpBody, errorMessage: error.localizedDescription, forStatusCode: response.statusCode, responseTime: timeTaken)))
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    //MARK: - GET Data
    func getData(url: String, completionHandler:@escaping(Result<HttpResults, HttpErrors>)-> Void) {
        
        guard let serviceUrl = URL(string: url) else { return }
        
        /// To get Response Time of Request sent
        var timeTaken: TimeInterval = 0
        serviceUrl.responseTime { (time) in
            if let responseTime = time {
                timeTaken = responseTime
            }
        }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {return}
            
            if let data = data {
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(.success(HttpResults(withServerResponse: data, forStatusCode: response.statusCode, errorMessage: HttpResponseCode.code(code: response.statusCode), responseTime: timeTaken)))
                    
                } catch {
                    completionHandler(.failure(HttpErrors(withServerResponse: data, forRequestUrl: request.url!, withHttpBody: request.httpBody, errorMessage: error.localizedDescription, forStatusCode: response.statusCode, responseTime: timeTaken)))
                    print(error)
                }
            }
        }.resume()
    }
}
