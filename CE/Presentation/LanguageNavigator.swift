//
//  LanguageNavigator.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

struct LanguageNavigation: Hashable {
    let languageName: String
    let countries: [CountryElement]
    
    static func == (lhs: LanguageNavigation, rhs: LanguageNavigation) -> Bool {
        lhs.languageName == rhs.languageName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(languageName)
    }
}
