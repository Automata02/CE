//
//  CountryListItem.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

struct CountryListItem: Identifiable {
    let country: CountryElement
    let isFavorite: Bool
    
    var id: String { country.id }
}
