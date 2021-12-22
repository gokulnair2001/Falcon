//
//  HttpResponseTime.swift
//  Falcon
//
//  Created by Gokul Nair on 22/12/21.
//

import Foundation

extension URL {

    /** Request the http status of the URL resource by sending a "HEAD" request over the network. A nil response means an error occurred. */
    public func requestHTTPStatus(completion: @escaping (_ status: Int?) -> Void) {
        var request = URLRequest(url: self)
        request.httpMethod = "HEAD"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, error == nil {
                completion(httpResponse.statusCode)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    /** Measure the response time in seconds of an http "HEAD" request to the URL resource. A nil response means an error occurred. */
    public func responseTime(completion: @escaping (TimeInterval?) -> Void) {
        let startTime = DispatchTime.now().uptimeNanoseconds
        requestHTTPStatus { (status) in
            if status != nil {
                let elapsedNanoseconds = DispatchTime.now().uptimeNanoseconds - startTime
                completion(TimeInterval(elapsedNanoseconds)/1e9)
            }
            else {
                completion(nil)
            }
        }
    }
}
