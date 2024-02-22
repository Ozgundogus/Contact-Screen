//
//  APIURLs.swift
//  Contact Screen
//
//  Created by Ozgun Dogus on 17.02.2024.
//

import Foundation

enum NewsAPI {
    private static let baseURL = "https://newsapi.org/v2/"
    private static let apiKey = "726b34c71f2f46dc9fb3acfa17ec913b"

    static func topHeadlines(country: String = "us") -> String {
        return "\(baseURL)top-headlines?country=\(country)&apiKey=\(apiKey)"
    }

    
    static func headlinesForCategory(_ category: String, country: String = "us") -> String {
        return "\(baseURL)top-headlines?country=\(country)&category=\(category)&apiKey=\(apiKey)"
    }
}

