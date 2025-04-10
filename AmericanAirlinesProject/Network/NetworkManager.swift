//
//  APIServiceManager.swift
//  
//
//  Created by Sagar Amin on 3/22/25.
//

import Foundation


class NetworkManager {
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}


protocol APIService {
    
    func fetchData<T: Decodable>(
            url: URL,
            modelType: T.Type
    ) async throws -> T
}


extension NetworkManager: APIService {
    func fetchData<T: Decodable>(
        url: URL,
        modelType: T.Type
    ) async throws -> T where T: Decodable {
        do {
            
            let (data, response) = try await urlSession.data(from: url) // called api endpoint and get response
            
            
            if response.isValideResponse() { // response is Ok. we should parse the json response
                
                let parsedData = try JSONDecoder().decode(modelType, from: data)
                
                return parsedData
            }
            else {
                throw URLError(.badServerResponse)
            }
        } catch {
            throw error
        }
    }

}


extension URLResponse {
    func isValideResponse() -> Bool {
        guard let httpURLResponse = self as? HTTPURLResponse else {
            return false
        }
        switch httpURLResponse.statusCode {
            case 200..<300:
            return true
        default:
            return false
        }
        
    }
}
