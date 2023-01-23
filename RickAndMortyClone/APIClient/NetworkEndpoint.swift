//
//  NetworkEndpoint.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 31/12/2022.
//

import Foundation

/// Represents unique api endpoint
@frozen enum NetworkEndpoint: String,CaseIterable, Hashable {
    ///Endpoint to get character info
    case character
    ///Endpoint to get location info
    case location
    ///Endpoint to get episode info
    case episode
}
