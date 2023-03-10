//
//  EpisodeDetailViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 14/1/2023.
//

import UIKit

final class EpisodeDetailViewController: UIViewController, EpisodeDetailViewModelDelegate, EpisodeDetailViewDelegate {
    
    private let viewModel: EpisodeDetailViewModel
    
    private let detailView =  EpisodeDetailView()
    
    //MARK: - Init
    init(url: URL?) {
        self.viewModel = EpisodeDetailViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle Mehods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    @objc
    private func didTapShare() {
        
    }

    //MARK: - View Delegate
    func episodeDetailView(_ detailView: EpisodeDetailView, didSelect character: Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - ViewModelDelegate
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
    
}
  
