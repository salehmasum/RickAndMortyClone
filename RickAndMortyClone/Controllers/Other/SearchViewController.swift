//
//  SearchViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 20/1/2023.
//

import UIKit

//Dynamic Search Option View
//Render Results
//Render no results zero state
//Searching  / API call

/// Configurable controller to search
final class SearchViewController: UIViewController {
    
    /// Configuration for search session
    struct Config {
        enum `Type` {
            case character // name | status | gender
            case episode //  name
            case location // name | type
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .episode:
                    return "Search Episodes"
                case .location:
                    return "Search Locations"
                }
            }
        }
        let type: `Type`
    }
    
    private let viewModel: SearchViewModel
    private let searchView: SearchView
    
    //MARK: - Init
    
    init(config: Config) {
        self.viewModel = SearchViewModel(config: config)
        self.searchView = SearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubviews(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search",
            style: .done,
            target: self, action: #selector(didTapSearch)
        )
    }
     
    @objc private func didTapSearch() {
        //viewModel.executeSearch()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
