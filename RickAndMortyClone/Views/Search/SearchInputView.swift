//
//  SearchInputView.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 1/2/2023.
//

import Foundation
import UIKit

final class SearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: SearchInputViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            let options = viewModel.options
            createOptionSelectionView(options: options)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
        addSubviews(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
    
    private func createOptionSelectionView(options: [SearchInputViewModel.DynamicOption]) {
        for option in options {
            print(option.rawValue)
        }
    }
    
    func configure(with viewModel: SearchInputViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        //TODO: Fix height of input view for episode with no option
        self.viewModel = viewModel
    }
    
}
