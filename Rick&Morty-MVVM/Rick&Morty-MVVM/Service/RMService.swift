//
//  RMService.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//

import Foundation

final class RMService {
    static let shared = RMService()
    private init() {}
    
    func getCharacters(completion: @escaping ([Results]?, String?) -> ()) {
        let url = URLBuilder().build()
        
        NetworkManager.shared.request(type: Character.self , url: url, method: .get) { response in
            switch response {
            case .success(let items):
                completion(items.results, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
