//
//  ImageModel.swift
//  Falcon
//
//  Created by Gokul Nair on 18/12/21.
//

import Foundation

struct Request {
    let endpoint : URL
    let request: Decodable
}

struct ImageRequest : Decodable
{
    let file: Data
    let name : String
}

struct ImageResponse: Decodable {
    let isSuccess: Bool
    let message, response: String?
}
