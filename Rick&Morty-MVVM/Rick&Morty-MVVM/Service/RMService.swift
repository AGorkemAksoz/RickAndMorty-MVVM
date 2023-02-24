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
        let url = URLBuilder().buildURL()
        
        NetworkManager.shared.request(type: Characters.self , url: url, method: .get) { response in
            switch response {
            case .success(let items):
                completion(items.results, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getCharacter(id: Int, completion: @escaping (Results?, String?) -> ()) {
        let url = URLBuilder().buildDetailURL(id: id)
        
        NetworkManager.shared.request(type: Results.self, url: url, method: .get) { response in
            switch response {
            case .success(let item):
                completion(item, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
        
    }
}
