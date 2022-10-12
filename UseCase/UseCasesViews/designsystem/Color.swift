//
//  Color.swift
//  UseCase
//
//  Created by Rodrigo Souza on 04/10/22.
//

import UIKit

enum Color: String, CaseIterable {
    //Base Colors
    case primary = "Primary"
    case error = "Error"

    // Text Colors
    case textPrimary = "Text Primary"
    case textSecondary = "Text Secondary"

    //Background Colors
    case backgroundPrimary = "Background Primary"
    case backgroundSecondary = "Background Secondary"

    //Action Text Colors
    case actionTextPrimary = "Action Text Primary"
    case actionTextOnColor = "Action Text On Color"
}

extension UIColor {
    convenience init(color: Color) {
        self.init(named: color.rawValue)!
    }
}
