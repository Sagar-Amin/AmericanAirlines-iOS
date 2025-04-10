//
//  APIConstants.swift
//
//  Created by Sagar Amin on 3/22/25.
//

import Foundation

// Shared across all instances of `APIConstants` and can be accessed without creating an instance of the struct

struct APIEndpoint {
    let baseURL = "https://api.duckduckgo.com"
    
    //    Example search:
    //    https://api.duckduckgo.com/?q={American+Airlines}&format=json&pretty=1
    
    func searchURL(query: String) -> String {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return "\(baseURL)/?q=\(encoded)&format=json&pretty=1"
    }

}
