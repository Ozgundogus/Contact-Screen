//
//  NetworkManager.swift
//  Contact Screen
//
//  Created by Ozgun Dogus on 15.02.2024.
//

import Foundation

enum NetworkError: String, Error {
    case requestFailed = "requestFailed"
    case invalidData = "invalidData"
}

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func performRequest(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            completion(.success(data))
        }.resume()
    }
}


