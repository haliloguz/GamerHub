//
//  NetworkManager.swift
//  Gamer Hub
//
//  Created by Halil Oğuz on 25.05.2023.
//

import Foundation

struct Constants {
    
    static let gamesUrl = "https://api.rawg.io/api/games?key=9ddf56c450b34ea889c13859a9156f02"
    static let searchUrl = "https://api.rawg.io/api/games?search="
    static let keyUrl = "&key=9ddf56c450b34ea889c13859a9156f02"
    
}

extension URLSession {
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable>(url: URL?, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = dataTask(with: url) {data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(model, from: data)
                completion(.success(result))
                
            }
            catch {
                
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
