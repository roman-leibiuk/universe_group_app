//
//  String+Extension.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation

extension String {
    func localized() -> String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable")
    }
}
