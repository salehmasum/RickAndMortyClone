//
//  GetLocationsResponse.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/1/2023.
//

import Foundation

struct GetLocationsResponse: Codable {
    let info: Info
    let results: [Location]
}
