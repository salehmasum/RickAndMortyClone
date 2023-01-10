//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 10/1/2023.
//

import Foundation

final class CharacterPhotoCollectionViewCellViewModel {
    
    private let imageUrl: URL?
    
    init (imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL))) 
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
}
