//
//  CharacterListViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 2/1/2023.
//

import Foundation
import UIKit


protocol CharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: Character)
}

/// ViewModel to handle character list view logic
final class CharacterListViewModel: NSObject {
    
    public weak var delegate: CharacterListViewModelDelegate?
    
    private var isLoadingNextPage = false
    
    private var characters: [Character] = [] {
        didSet {
            for character in characters
            {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
                
            }
        }
    }
    
    private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: Info? = nil
    
    /// Fetch Initial set of characters (20)
    public func fetchCharacters() {
        NetworkService.shared.execute(
            NetworkRequest.listCharacterRequests,
            expecting: GetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                let info = responseModel.info
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingNextPage else {
            return
        }
        isLoadingNextPage = true
        guard let request = NetworkRequest(url: url) else {
            isLoadingNextPage = false
            return
        }
        NetworkService.shared.execute(request, expecting: GetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                strongSelf.characters.append(contentsOf: moreResults)
                strongSelf.apiInfo = responseModel.info
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with: indexPathsToAdd
                    )
                    strongSelf.isLoadingNextPage = false
                }
                
            case .failure(let error):
                print(String(describing: error))
                strongSelf.isLoadingNextPage = false
            }
        }
    }
        
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}

/// CollectionView Data source and delegate
extension CharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        self.delegate?.didSelectCharacter(character)
    }
    
    //MARK: - CollectionViewFooter
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError("Unsupported")
        }
        let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as! FooterLoadingCollectionReusableView
        
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
}

//MARK: - ScrollView
extension CharacterListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingNextPage,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let scrollViewFrameHeight = scrollView.frame.size.height
            let footerHeight: CGFloat = 100 + 20 // 20 is additional buffer optional

            if offset >= (totalContentHeight - scrollViewFrameHeight - footerHeight) {
                self?.fetchAdditionalCharacters(url: url)
            }
            timer.invalidate()
        }

    }
}
