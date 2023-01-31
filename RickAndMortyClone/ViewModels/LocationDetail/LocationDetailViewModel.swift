//
//  LocationDetailViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 31/1/2023.
//

import Foundation

protocol LocationDetailViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}
 
final class LocationDetailViewModel {
    
    private let endpointUrl: URL?
    private var dataTuple: (location: Location, characters: [Character])? {
        didSet {
            createCellViewModel()
            delegate?.didFetchLocationDetails()
        }
    }
    
    public weak var delegate: LocationDetailViewModelDelegate?
    
    enum SectionType {
        case information(viewModel: [EpisodeInformationCollectionViewCellViewModel])
        case characters(viewModel: [CharacterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    //MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        
    }
    
    public func character(at index: Int) -> Character? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }
    
    //MARK: - private
    private func createCellViewModel() {
        guard let dataTuple = self.dataTuple else {
            return
        }
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let createdDate = CharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = CharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: createdDate)
        }
        
        cellViewModels = [
            .information(viewModel: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModel: characters.compactMap({
                return CharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image)
                )
            }))
        ]
    }
    
    /// Fetch backing location model
    public func fetchLocationData() {
        guard let url = endpointUrl,
              let request = NetworkRequest(url: url) else {
            return
        }
        
        NetworkService.shared.execute(request, expecting: Location.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location: model)
            case .failure:
                break
            }
        }
        
    }
    
    private func fetchRelatedCharacters(location: Location) {
        let characterRequests: [NetworkRequest] = location.residents.compactMap({
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
                location: location,
                characters: characters
            )
        }
    }
}

