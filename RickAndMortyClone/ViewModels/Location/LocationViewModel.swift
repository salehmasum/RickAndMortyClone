//
//  LocationViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 29/1/2023.
//

import UIKit

final class LocationViewModel {
    
    private var locations: [Location] = []
    
    private var cellViewModels: [String] = []
    
    init() {
        
    }
    
    public func fetchLocations() {
        NetworkService.shared.execute(
            .listLocationsRequests,
            expecting: String.self
        ) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
    
}
