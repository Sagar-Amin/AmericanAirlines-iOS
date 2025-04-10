//
//  ListCell.swift
//  AmericanAirlinesProject
//
//  Created by Sagar Amin on 3/22/25.
//

import SwiftUI

struct ListCell:View {
    
    let title: String
    let url : String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(url)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
