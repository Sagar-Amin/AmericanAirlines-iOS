//
//  Response.swift
//
//
//  Created by Sagar Amin on 3/22/25.
//


struct Response: Decodable {
    let Abstract: String
    let AbstractSource: String
    let AbstractURL: String
    let OfficialDomain: String
    
    let Results: [Result]
    let RelatedTopics: [Result]
}

struct Result: Decodable {
    let FirstURL: String
    let Result: String
    let Text: String
}

extension Response: Identifiable {
    var id: String {
        return AbstractURL
    }
}
