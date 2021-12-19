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

    init(withServerResponse response: Data? = nil, forRequestUrl url: URL, withHttpBody body: Data? = nil, errorMessage message: String, forStatusCode statusCode: Int)
    {
        self.serverResponse = response != nil ? String(data: response!, encoding: .utf8) : nil
        self.requestUrl = url
        self.requestBody = body != nil ? String(data: body!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
        self.reason = message
    }
}

//MARK: - Success Response
struct HttpResults {
    let data: Data?
    let httpStatusCode: Int?
    let httpStatusCodeDescription: String?
    
    init(withServerResponse response: Data? = nil, forStatusCode statusCode: Int, errorMessage message: String){
        self.data = response
        self.httpStatusCode = statusCode
        self.httpStatusCodeDescription = message
    }
}
