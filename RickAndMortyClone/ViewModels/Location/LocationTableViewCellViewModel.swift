//
//  LocationTableViewCellViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/1/2023.
//

import Foundation

struct LocationTableViewCellViewModel: Hashable, Equatable {
    
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    public var name: String {
        return location.name
    }
    
    public var type: String {
        return "Type: "+location.type
    }
    
    public var dimention: String {
        return location.dimension
    }
    
    static func == (lhs: LocationTableViewCellViewModel, rhs: LocationTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
       // return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location.id)
        hasher.combine(name)
        hasher.combine(dimention)
        hasher.combine(type)
    }
    
}
