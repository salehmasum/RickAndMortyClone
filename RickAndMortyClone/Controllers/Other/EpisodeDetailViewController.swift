//
//  EpisodeDetailViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 14/1/2023.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    //MARK: - Init
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle Mehods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
    }

}
