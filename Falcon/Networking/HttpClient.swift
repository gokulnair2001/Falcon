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
                print("🔥 data")
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
    func getData(url: String, completionHandler:@escaping(Result<Data, HttpErrors>)-> Void) {
        print("🔥1")
        guard let serviceUrl = URL(string: url) else { return }
        print("🔥2")
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        print("🔥3")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            print("🔥4")
           
           // guard let response = response as? HTTPURLResponse else {return}
            print("🔥5")
            if let data = data {
                print("🔥 \(data)")
                do {
                    let _ = try JSONSerialization.jsonObject(with: data, options: [])
                    completionHandler(.success(data))
                } catch {
                    completionHandler(.failure(HttpErrors(withServerResponse: data, forRequestUrl: request.url!, withHttpBody: request.httpBody, errorMessage: error.localizedDescription, forStatusCode: 200)))
                    print(error)
                }
            }
        }.resume()
    }
    
    //MARK: - IMAGE UPLOAD Request
    
    func uploadImage<T: Decodable>(data: Data, url: String, completionHandler: @escaping(_ result: T?) -> Void) {

        let imageUploadRequest = ImageRequest(file: data, name: "\(UUID()).jpeg")
        let requestParams = Request(endpoint: URL(string: url)!, request: imageUploadRequest)

        postImage(requestParameters:requestParams, url: url, resultType: ImageResponse.self) { result in
            completionHandler(result as? T)
        }
    }
    
    func postImage<T:Decodable>(requestParameters: Request, url: String, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
    {
        let urlRequest = createPostImageRequest(requestUrl: URL(string: url)!, request: requestParameters.request as! ImageRequest)

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

            if(error == nil && data != nil) {
                do{
                    let result = try JSONDecoder().decode(resultType.self, from: data!)
                    completionHandler(result)
                    print(result)
                }
                catch{
                    debugPrint(error)
                }
            }

            completionHandler(nil)

        }.resume()
    }

    private func createPostImageBody(request: ImageRequest, boundary:String) -> Data {

        var requestData = Data()

        let lineBreak = "\r\n"
        requestData.append("--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestData.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(request.name)\" \(lineBreak)" .data(using: .utf8)!)
        requestData.append("Content-Type: \("image/jpeg" + lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append(request.file)
        requestData.append("\(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append("\(lineBreak)" .data(using: .utf8)!)
        requestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)

        return requestData
    }

    private func createPostImageRequest(requestUrl: URL, request: ImageRequest) -> URLRequest {

        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        urlRequest.addValue("connect.sid=s%3AVd9MqI9LZCCkEyQkWnOd3aJvkU8Ff7kr.x6pnH6EsMWoTfBfl0b1Qz78AIazz9vurDrr%2BrGj7KXQ", forHTTPHeaderField: "Cookie")
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        let requestBody = createPostImageBody(request: request, boundary: boundary)
        urlRequest.addValue("\(requestBody.count)", forHTTPHeaderField: "Content-Length")
        urlRequest.httpBody = requestBody

        return urlRequest
    }
}
