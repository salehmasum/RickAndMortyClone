//
//  EpisodeDetailViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 19/1/2023.
//

import Foundation

protocol EpisodeDetailViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class EpisodeDetailViewModel {
    
    private let endpointUrl: URL?
    private var dataTuple: (Episode, [Character])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    public weak var delegate: EpisodeDetailViewModelDelegate?
    
    enum SectionType {
        case information(viewModel: [EpisodeInformationCollectionViewCellViewModel])
        case characters(viewModel: [CharacterCollectionViewCellViewModel])
    }
    
    public private(set) var sections: [SectionType] = [] 
    
    //MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        
    }
    
    //MARK: - public
    
    
    //MARK: - private
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = NetworkRequest(url: url) else {
            return
        }
        
        NetworkService.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure:
                break
            }
        }
        
    }
    
    private func fetchRelatedCharacters(episode: Episode) {
        let characterRequests: [NetworkRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return NetworkRequest(url: $0)
        })
        
        //10s of parallel requests
        //Get notified when done
        let group = DispatchGroup()
        var characters: [Character] = []
        
        for request in characterRequests {
            group.enter()
            NetworkService.shared.execute(request, expecting: Character.self) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (
                episode,
                characters
            )
        }
    }
}
 
