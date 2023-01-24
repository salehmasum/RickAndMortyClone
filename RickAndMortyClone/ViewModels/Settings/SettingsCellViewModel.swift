//
//  SettingsCellViewModel.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 24/1/2023.
//

import Foundation
import UIKit

struct SettingsCellViewModel: Identifiable, Hashable {
    
    let id = UUID()
    
    private let type: SettingsOption
    
    //MARK: - Init
    init(type: SettingsOption) {
        self.type = type
    }
    
    //MARK: - Public
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
}
