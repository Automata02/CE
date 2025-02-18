//
//  LanguageDetailView.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import SwiftUI

struct LanguageDetailView<ViewModel: ViewModelProtocol>: View {
    let languageName: String
    let countries: [CountryElement]
    @ObservedObject var viewModel: ViewModel
    
    var sortedCountries: [CountryElement] {
        countries.sorted { ($0.name?.common ?? "") < ($1.name?.common ?? "") }
    }
    
    var body: some View {
        List {
            ForEach(sortedCountries) { country in
                CountryRowView(
                    country: country,
                    isFavorite: viewModel.isFavorite(country),
                    viewModel: viewModel
                )
            }
        }
        .navigationTitle("\(languageName)-speaking countries")
        .navigationBarTitleDisplayMode(.inline)
    }
}
