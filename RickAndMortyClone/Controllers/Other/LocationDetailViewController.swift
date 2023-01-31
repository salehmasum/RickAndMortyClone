//
//  LocationDetailViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 31/1/2023.
//

import UIKit

final class LocationDetailViewController: UIViewController, LocationDetailViewModelDelegate, LocationDetailViewDelegate {
    
    
    private let viewModel: LocationDetailViewModel
    
    private let detailView =  RickAndMortyClone.LocationDetailView()
    
    //MARK: - Init
    init(location: Location) {
        let url = URL(string: location.url)
        self.viewModel = LocationDetailViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle Mehods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel.delegate = self
        viewModel.fetchLocationData()
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
    func LocationDetailView(_ detailView: LocationDetailView, didSelect character: Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - ViewModelDelegate
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
    
}
