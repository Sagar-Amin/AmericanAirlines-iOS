//
//  ViewModel.swift
//  
//
//  Created by Sagar Amin on 3/22/25.
//

import Foundation
import Combine


enum State {
    case loading
    case loaded
    case error(Error)
    case empty
}
     

class ViewModel : ObservableObject {
    
    @Published var searchText: String = ""
    @Published var results: Response?
    
    
    @Published var state: State = .empty
    
    
    
    private var networkmgr: NetworkManager!
    init(networkmgr: NetworkManager) {
        self.networkmgr = networkmgr
    }
    
    // call api and get response via Model
    @MainActor
    func getList(for text: String) async {
        state = .loading // inital status for calling api
        
        do {
            // call api and then get search list
            guard let url = URL(string: APIEndpoint().searchURL(query: text)) else {
                throw NetworkError.invalidURLError
            }
            
            results = try await networkmgr.fetchData(url: url, modelType: Response.self)
            
            
            state = .loaded
            
        } catch {
            // if any errors
            state = .error(error)
            
            switch error {
                case is DecodingError:
                    state = .error(error)
                case is URLError:
                    state = .error(NetworkError.isValideURL)
                case NetworkError.isValideURL:
                    state = .error(NetworkError.invalidURLError)
                default:
                    break
            }
        }
            
    }
    
}
