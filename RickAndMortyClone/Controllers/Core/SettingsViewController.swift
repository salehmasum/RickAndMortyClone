//
//  SettingsViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/12/2022.
//

import UIKit
import SwiftUI

/// Represents Controller to show various app Settings
final class SettingsViewController: UIViewController {

    private let settingsSwiftUIController = UIHostingController(
        rootView: SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({
            return SettingsCellViewModel(type: $0)
        })))
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            
        ])
    }
    
}
