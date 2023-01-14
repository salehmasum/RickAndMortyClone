//
//  CharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 10/1/2023.
//

import Foundation

protocol EpisodeDataRender {
    var episode: String { get }
    var name: String { get }
    var air_date: String { get }
}

final class CharacterEpisodeCollectionViewCellViewModel {
    
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    private var dataBlock: ((EpisodeDataRender) -> Void)?
    
    private var episode: Episode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    //MARK: - Init
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    //MARK: - Public
    public func registerForData(_ block: @escaping (EpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl, let request = NetworkRequest(url: url) else {
            return
        }
        isFetching = true
        NetworkService.shared.execute(request,
                            expecting: Episode.self)
        { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}
