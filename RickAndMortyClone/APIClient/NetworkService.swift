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
    ///   - completion: call back with data or error
    public func execute(_ request: NetworkRequest, completion: @escaping () -> Void) {
        
    }
}


