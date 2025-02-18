//
//  CountryRowView.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import SwiftUI

struct CountryRowView<ViewModel: ViewModelProtocol>: View {
    let country: CountryElement
    let isFavorite: Bool
    let viewModel: ViewModel
    let showFavoriteIndicator: Bool
    
    init(
        country: CountryElement,
        isFavorite: Bool,
        viewModel: ViewModel,
        showFavoriteIndicator: Bool = true
    ) {
        self.country = country
        self.isFavorite = isFavorite
        self.viewModel = viewModel
        self.showFavoriteIndicator = showFavoriteIndicator
    }
    
    var body: some View {
        NavigationLink(value: country) {
            HStack {
                Text(country.flagEmoji)
                Text(country.name?.common ?? Strings.unknown)
                Spacer()
                
                if showFavoriteIndicator && isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray.opacity(0.3))
                        .padding(.trailing, 5)
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(action: {
                viewModel.handleFavorite(for: country)
            }) {
                Image(systemName: isFavorite ? "star.slash.fill" : "star.fill")
            }
            .tint(isFavorite ? .red : .yellow)
        }
    }
}
