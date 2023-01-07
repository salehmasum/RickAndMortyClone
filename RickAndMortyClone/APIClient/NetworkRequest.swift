//
//  NetworkRequest.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 31/12/2022.
//

import Foundation

/// Objec that represents a single api call
final class NetworkRequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired End Point
    private let endpoint: NetworkEndpoint
    /// Path Components for API, if any
    private let pathComponents: [String]
    /// Query Arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { pathParam in
                string += "/\(pathParam)"
            }
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            //name=value&name=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed and Constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    // MARK: - Public
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target Endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: NetworkEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
               let endpointString = components[0]
                if let networkEndpoint = NetworkEndpoint(rawValue: endpointString) {
                    self.init(endpoint: networkEndpoint)
                    return
                }
            }
        }else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
               let endpointString = components[0]
                let queryItemsString = components[1]
                //value=name?value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })
                if let networkEndpoint = NetworkEndpoint(rawValue: endpointString) {
                    self.init(endpoint: networkEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
    
    
}

extension NetworkRequest {
    static let listCharacterRequests = NetworkRequest(endpoint: .character)
}
