//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 10/1/2023.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
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
    
    public func configure(with viewModel: CharacterInfoCollectionViewCellViewModel) {
        
    }
}
