//
//  CharacterDetailViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 5/1/2023.
//

import UIKit

/// Controller to show info about single character
final class CharacterDetailViewController: UIViewController {

    private let viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
