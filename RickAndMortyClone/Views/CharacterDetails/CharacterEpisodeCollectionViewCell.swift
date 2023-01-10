//
//  CharacterEpisodeCollectionViewCell.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 10/1/2023.
//

import UIKit

final class CharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: CharacterEpisodeCollectionViewCellViewModel) {
        
    }
    
}
