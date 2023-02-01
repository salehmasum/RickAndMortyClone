//
//  SearchViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 1/2/2023.
//

import Foundation

//Responsibilities
// - Show search results
// - Show no results view
// - Kick off api request

final class SearchViewModel {
    
    private let config: SearchViewController.Config
    
    init(config: SearchViewController.Config) {
        self.config = config
    }
}
