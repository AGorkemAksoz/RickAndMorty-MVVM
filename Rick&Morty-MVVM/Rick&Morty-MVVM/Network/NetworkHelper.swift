//
//  NetworkHelper.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//

import Foundation


enum ErrorTypes: String, Error {
    case invalidURL = "Invalid URL"
    case invalidData = "Invalid Data"
    case generalError = "An error happend"
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}
