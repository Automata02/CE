//
//  ListView.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.error {
                    Text("Error: \(error.errorDescription ?? error.localizedDescription)")
                } else {
                    SearchBar(text: $viewModel.searchText)
                    
                    List(viewModel.filteredCountriesWithStatus) { item in
                        CountryRowView(
                            country: item.country,
                            isFavorite: item.isFavorite,
                            viewModel: viewModel
                        )
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle(Strings.countries)
            .navigationDestination(for: CountryElement.self) { country in
                CountryDetailView(country: country, viewModel: viewModel)
            }
            .navigationDestination(for: LanguageNavigation.self) { languageNav in
                LanguageDetailView(
                    languageName: languageNav.languageName,
                    countries: languageNav.countries,
                    viewModel: viewModel
                )
            }
        }
        .onAppear {
            viewModel.fetchCountries()
        }
    }
}
