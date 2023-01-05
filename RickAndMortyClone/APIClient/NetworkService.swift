//
//  NetworkService.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 31/12/2022.
//

import Foundation

/// Primary Api Service Object to get Rick and Morty Api data
final class NetworkService {
    /// Shared Singleton Instance
    static let shared = NetworkService()
    
    /// Privatized Constructor
    private init() {}
    
    enum NetworkServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send Rick And Morty Api Call
    /// - Parameters:
    ///   - request: request instance
    ///   - typle: the type of object we expect to get back
    ///   - completion: call back with data or error
    public func execute<T: Codable>(
        _ request: NetworkRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(NetworkServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkServiceError.failedToGetData))
                return
            }
            
            //Decode resposne
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - private
    private func request(from networkRequest: NetworkRequest) -> URLRequest? {
        guard let url = networkRequest.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = networkRequest.httpMethod
        return request
    }
}


