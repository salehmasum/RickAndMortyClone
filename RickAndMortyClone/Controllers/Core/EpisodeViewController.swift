//
//  EpisodeViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/12/2022.
//

import UIKit

/// Represents Controller to show and display Episodes
final class EpisodeViewController: UIViewController, EpisodeListViewDelegate {
    
    private let episodeListView = EpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
       // view.backgroundColor = .systemBackground
        setUpView()
        episodeListView.delegate = self
        addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        let vc = SearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpView() {
        view.addSubview(episodeListView)
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    //MARK: - EpisodeListViewDelegate Method
    func episodeListView(_ episodeListView: EpisodeListView, didSelectEpisode episode: Episode) {
        //Open detail controller for that character
        let detailVc = EpisodeDetailViewController(url: URL(string: episode.url))
        detailVc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
