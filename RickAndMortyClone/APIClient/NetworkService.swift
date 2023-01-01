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
        
    }
}


