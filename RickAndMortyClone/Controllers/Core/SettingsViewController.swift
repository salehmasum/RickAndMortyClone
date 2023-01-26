//
//  SettingsViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/12/2022.
//

import SafariServices
import UIKit
import SwiftUI
import StoreKit

/// Represents Controller to show various app Settings
final class SettingsViewController: UIViewController {

    private var settingsSwiftUIController: UIHostingController<SettingsView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        
        let settingsSwiftUIController =  UIHostingController(
            rootView: SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({
                return SettingsCellViewModel(type: $0) { [weak self] option in
                    print(option.displayTitle)
                    self?.handleTap(option: option)
                }
            })))
        )
        
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
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: SettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            //Open Website
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }else {
            if let windowScene = view.window?.windowScene
             {
                SKStoreReviewController.requestReview(in: windowScene)
               
            }
        }

    }
    
}
