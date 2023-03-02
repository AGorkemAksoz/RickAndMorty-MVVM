//
//  URLBuilder.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//  https://rickandmortyapi.com/api/character/?name=rick

import Foundation

protocol URLBuilderInterface {
    func buildURL() -> String
    func buildDetailURL(id: Int) -> String
    func buildNamedURL(name:String) -> String
}

final class URLBuilder:URLBuilderInterface {

    private let baseURL = "https://rickandmortyapi.com"
    private let path = "/api/character"
    private let search = "/?name="
    

    func buildURL() -> String {
        baseURL + path
    }
    
    func buildDetailURL(id: Int) -> String {
        "\(baseURL + path)/\(id)"
    }
    
    func buildNamedURL(name: String) -> String {
        "\(baseURL + path + search  + name)"
    }
    
}
