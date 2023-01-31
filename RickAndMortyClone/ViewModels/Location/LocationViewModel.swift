//
//  LocationViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 29/1/2023.
//

import UIKit

protocol LocationViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class LocationViewModel {
    
    public weak var delegate: LocationViewModelDelegate?
    
    private var locations: [Location] = [] {
        didSet {
            for location in locations {
                let cellViewModel = LocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel){
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    //Location response info will
    //contain next url if present
    private var locationInfo: Info?
    
    public private(set) var cellViewModels: [LocationTableViewCellViewModel] = []
    
    init() {
        
    }
    
    public func location(at index: Int) -> Location? {
        if (index >= locations.count) {
            return nil
        }
        return self.locations[index]
    }
    
    public func fetchLocations() {
        NetworkService.shared.execute(
            .listLocationsRequests,
            expecting: GetLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.locationInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
    
}
