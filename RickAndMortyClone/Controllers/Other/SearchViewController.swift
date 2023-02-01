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
    
    private let config: Config
    
    //MARK: - Init
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
    }
    
    

}
