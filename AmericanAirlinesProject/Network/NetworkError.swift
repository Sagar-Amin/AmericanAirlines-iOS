//
//  APIError.swift
//  
//
//  Created by Sagar Amin on 3/22/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURLError
    case parsingError
    case noDataError
    case responseCodeError(Int) // 200 - 299  : fine code for endpoint
    case isValideURL
    case isValidResponse
    
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURLError:
            return "Invalid URL"
        case .parsingError:
            return "Parsing Error"
        case .noDataError:
            return "No Data"
        case .responseCodeError(let code):
            return "Response Code: \(code)"
        case .isValideURL:
            return "URL is Invalid"
        case .isValidResponse:
            return "Response is inValid"
        }
    }
}
