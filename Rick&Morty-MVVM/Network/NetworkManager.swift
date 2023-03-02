//
//  NetworkManager.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
// 

import Foundation

protocol NetworkManagerInterface {
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethods, completion: @escaping (Result<T, ErrorTypes>) -> ())
    func handleWithData<T:Codable>(data: Data, completion: @escaping (Result<T, ErrorTypes>) -> ())
}


final class NetworkManager: NetworkManagerInterface {
    
    static let shared = NetworkManager()
    private init() {}
    
    func request<T>(type: T.Type, url: String, method: HTTPMethods, completion: @escaping (Result<T, ErrorTypes>) -> ()) where T : Decodable, T : Encodable {
        let session = URLSession.shared
        
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = session.dataTask(with: request) {[weak self] data, response, error in
                if let _ = error {
                    completion(.failure(.generalError))
                } else if let data = data {
                    self?.handleWithData(data: data, completion: { response in
                        completion(response)
                    })
                } else {
                    completion(.failure(.invalidURL))
                }
            }
            dataTask.resume()
        }
    }
    
    func handleWithData<T>(data: Data, completion: @escaping (Result<T, ErrorTypes>) -> ()) where T : Decodable, T : Encodable {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch  {
            completion(.failure(.invalidData))
        }
    }
    
}
