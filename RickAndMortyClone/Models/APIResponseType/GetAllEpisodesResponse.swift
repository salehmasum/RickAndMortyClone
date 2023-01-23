//
//  GetAllEpisodesResponse.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 19/1/2023.
//

import Foundation

struct GetAllEpisodesResponse: Codable {
    let info: Info
    let results: [Episode]
}
