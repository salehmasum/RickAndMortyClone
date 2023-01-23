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
    
    private let cacheManager = APICacheManager()
    
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
        //Check if data is available in Cache
        if let cachedData = cacheManager.cachedResponse(
            for: request.endpoint,
            url: request.url
        ) {
            print("Using cached api response")
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(NetworkServiceError.failedToCreateRequest))
            return
        }
       
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkServiceError.failedToGetData))
                return
            }
            
            //Decode resposne
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data
                )
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


