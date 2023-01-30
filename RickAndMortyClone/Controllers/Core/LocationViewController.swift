//
//  LocationViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/12/2022.
//

import UIKit

/// Represents Controller to show and display Locations
final class LocationViewController: UIViewController, LocationViewModelDelegate {

    private let primaryView = LocationView()
    
    private let viewModel = LocationViewModel()
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        view.backgroundColor = .systemBackground
        addSearchButton()
        view.addSubview(primaryView)
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func didTapSearch() {
        
    }

    //MARK: - LocationViewModel delegate
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
    
}
