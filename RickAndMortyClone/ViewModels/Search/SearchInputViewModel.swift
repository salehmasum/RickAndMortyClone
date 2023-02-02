//
//  SearchInputViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 1/2/2023.
//

import Foundation

final class SearchInputViewModel {
    private let type: SearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    init(type: SearchViewController.Config.`Type`) {
        self.type = type
    }
    
    //MARK: - Public
    public var hasDynamicOptions: Bool {
        switch type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    public var searchPlaceholderText: String {
        switch type {
        case .character:
            return "Character Name"
        case .location:
            return "Location Name"
        case .episode:
            return "Episode Title"
        }
    }
    
}

