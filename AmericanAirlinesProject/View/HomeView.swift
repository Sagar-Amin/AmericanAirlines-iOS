//
//  HomeView.swift
//
//
//  Created by Sagar Amin on 3/22/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ViewModel(networkmgr: NetworkManager())
    
    
    var body: some View {
        NavigationStack {
            VStack () {
                
                HStack {
                    TextField("Search...", text: $viewModel.searchText)
                        .frame(height: 50)
                        .padding(.horizontal, 10)
                        
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button("Search") {
                        Task {
                            await viewModel.getList(for: viewModel.searchText)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .background(Color.white)
                
             
                                
                switch viewModel.state {
                case .loading:  // 2nd step
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    
                case .loaded:    // final step
                    displayList()
                    
                case .error(let error):   // except
                    displayError(error: error)
                    
                case .empty:   // 1st step
                    displayInit()
                    
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
    
    @ViewBuilder
    func displayError(error: Error) -> some View {
        Text("Error: \(error.localizedDescription)")
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func displayList() -> some View {
 
        List {
            if let results = viewModel.results?.Results, !results.isEmpty {
                Section(header:
                    Text("RESULTS")){
                    ForEach(results, id: \.FirstURL) { result in
                        ListCell(title: result.Text, url: result.FirstURL)
                    }
                }
            }
            
            if let results = viewModel.results?.RelatedTopics, !results.isEmpty {
                Section(header:
                    Text("RELATED TOPICS")){
                    ForEach(results, id: \.FirstURL) { result in
                        ListCell(title: result.Text, url: result.FirstURL)
                    }
                }
            }
            
        }
        .listStyle(PlainListStyle())
        .padding(0)
    }
    
    @ViewBuilder
    func displayInit() -> some View {
        
        Text("Welcome to our App!")
            .font(.title)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
}
