//
//  Extensions.swift
//  RickAndMortyClone
//
//  Created by Saleh Masum on 3/1/2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

