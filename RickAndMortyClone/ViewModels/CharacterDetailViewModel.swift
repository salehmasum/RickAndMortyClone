//
//  CharacterDetailViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 5/1/2023.
//

import Foundation

final class CharacterDetailViewModel {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    public var title: String {
        return self.character.name.uppercased()
    }
    
}
