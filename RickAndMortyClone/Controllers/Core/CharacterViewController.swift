//
//  CharacterViewController.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 30/12/2022.
//

import Foundation
import UIKit

/// Represents Controller to show and display and Search characters
final class CharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        
        let request = NetworkRequest(
            endpoint: .character,
            pathComponents: ["1"]
        )
        print(request.url)
        
        NetworkService.shared.execute(
            request,
            expecting: String.self
        ) { result in
            
        }
    }
    
}
