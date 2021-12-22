//
//  HttpResponses.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import Foundation

//MARK: - Failure Response
struct HttpErrors : Error
{
    let reason: String?
    let httpStatusCode: Int?
    let requestUrl: URL?
    let requestBody: String?
    let serverResponse: String?
    let responseTime: TimeInterval?

    init(withServerResponse response: Data? = nil, forRequestUrl url: URL, withHttpBody body: Data? = nil, errorMessage message: String, forStatusCode statusCode: Int, responseTime: TimeInterval)
    {
        self.serverResponse = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestUrl = url
        self.requestBody = body != nil ? String(data: body!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
        self.reason = message
        self.responseTime = responseTime
    }
}

//MARK: - Success Response
struct HttpResults {
    let data: Data?
    let httpStatusCode: Int?
    let httpStatusCodeDescription: String?
    let responseTime: TimeInterval?
    
    init(withServerResponse response: Data? = nil, forStatusCode statusCode: Int, errorMessage message: String, responseTime: TimeInterval){
        self.data = response
        self.httpStatusCode = statusCode
        self.httpStatusCodeDescription = message
        self.responseTime = responseTime
    }
}
