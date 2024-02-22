//
//  NewsService.swift
//  Contact Screen
//
//  Created by Ozgun Dogus on 13.02.2024.
//

import Foundation

class NewsService {
    private var baseURL = "https://newsapi.org/v2/"
    private let apiKey = "726b34c71f2f46dc9fb3acfa17ec913b"

    func fetchTopHeadlines(completion: @escaping (Result<Welcome, Error>) -> Void) {
        let urlString = NewsAPI.topHeadlines(country: "tr")
        guard let url = URL(string: urlString) else { return }

        NetworkManager.shared.performRequest(url: url) { /*[weak self]*/ result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(Welcome.self, from: data)
                    DispatchQueue.main.async {
//                        self?.baseURL = ""
                        completion(.success(responseObject))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

  
}

