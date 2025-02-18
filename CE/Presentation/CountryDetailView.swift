//
//  CountryDetailView.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import SwiftUI

struct CountryDetailView<ViewModel>: View where ViewModel: ViewModelProtocol {
    let country: CountryElement
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            HeaderRowView(country: country, isFavorite: viewModel.isFavorite(country)) {
                viewModel.handleFavorite(for: country)
            }
            
            Section(country.name?.common ?? Strings.notApplicable) {
                InfoRowView(
                    label: Strings.officialName,
                    value: country.name?.official ?? Strings.notApplicable)
                InfoRowView(label: Strings.countryCode,
                        value: country.cca2 ?? Strings.notApplicable)
            }
            if let population = country.population {
                Section(Strings.population) {
                    InfoRowView(
                        label: Strings.totalPopulation,
                        value: (population).formatted(.number)
                    )
                    InfoRowView(
                        label: Strings.globalRank,
                        value: "\(viewModel.getPopulationRank(for: country).ordinalized) most populous"
                    )
                }
            }
            
            if !languageGroups.isEmpty {
                Section(Strings.languages) {
                    ForEach(languageGroups, id: \.code) { group in
                        NavigationLink(value: LanguageNavigation(
                            languageName: group.language,
                            countries: group.countries
                        )) {
                            HStack {
                                Text(group.language)
                                Spacer()
                                Text("\(group.countries.count) countries")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            
            if let coordinates = country.latlng, coordinates.count >= 2 {
                Section(Strings.location) {
                    CountryMapView(
                        latitude: coordinates[0],
                        longitude: coordinates[1],
                        title: country.name?.common ?? Strings.unknown
                    )
                    .listRowInsets(EdgeInsets())
                }
            }
            
            if !neighboringCountries.isEmpty {
                Section(Strings.neighboringCountries) {
                    ForEach(neighboringCountries) { neighbor in
                        CountryRowView(
                            country: neighbor,
                            isFavorite: viewModel.isFavorite(neighbor),
                            viewModel: viewModel
                        )
                    }
                }
            }
        }
        .navigationTitle(country.name?.common ?? Strings.notApplicable)
    }
    
    private var neighboringCountries: [CountryElement] {
        guard let borders = country.borders else { return [] }
        return viewModel.countries.filter { country in
            borders.contains(country.cca3 ?? "")
        }
    }
    
    private var languageGroups: [(language: String, code: String, countries: [CountryElement])] {
        guard let languages = country.languages else { return [] }
        
        return languages.map { code, name in
            let countriesWithLanguage = viewModel.countries.filter { otherCountry in
                otherCountry.languages?.values.contains(name) == true
            }
            return (name, code, countriesWithLanguage)
        }.sorted { $0.language < $1.language }
    }
}
