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
    let viewModel: ViewModel
    
    var sortedCountries: [CountryElement] {
        countries.sorted { ($0.name?.common ?? "") < ($1.name?.common ?? "") }
    }
    
    var body: some View {
        List {
            ForEach(sortedCountries) { country in
                NavigationLink(value: country) {
                    HStack {
                        Text(country.flagEmoji)
                        Text(country.name?.common ?? Strings.notApplicable)
                        if viewModel.isFavorite(country) {
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundColor(.gray.opacity(0.3))
                        }
                    }
                }
            }
        }
        .navigationTitle("\(languageName)-speaking countries")
        .navigationBarTitleDisplayMode(.inline)
    }
}
