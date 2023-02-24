//
//  URLBuilder.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//  https://rickandmortyapi.com/api/character

import Foundation

protocol URLBuilderInterface {
    func build() -> String
}

final class URLBuilder:URLBuilderInterface {
    
    private let baseURL = "https://rickandmortyapi.com"
    private let path = "/api/character"
    

    func build() -> String {
        baseURL + path
    }
    
    
}
