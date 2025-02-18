//
//  ViewModel.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    var countries: [CountryElement] { get set }
    var error: NetworkError? { get set }
    var searchText: String { get set }
    var isLoading: Bool { get set }
    var filteredCountries: [CountryElement] { get }
    func fetchCountries()
    func getPopulationRank(for country: CountryElement) -> Int
    func handleFavorite(for country: CountryElement)
    func isFavorite(_ country: CountryElement) -> Bool
    var favorites: Set<String> { get }
}

class ViewModel: ViewModelProtocol {
    @Published var countries: [CountryElement] = []
    @Published var favorites: Set<String> = []
    @Published var error: NetworkError?
    @Published var searchText = ""
    @Published var isLoading = false
    
    init() {
        if let savedFavorites = UserDefaults.standard.array(forKey: "favoriteCountries") as? [String] {
            favorites = Set(savedFavorites)
        }
    }
    
    var filteredCountriesWithStatus: [CountryListItem] {
        filteredCountries.map { country in
            CountryListItem(
                country: country,
                isFavorite: isFavorite(country)
            )
        }
    }
    
    var filteredCountries: [CountryElement] {
        if searchText.isEmpty {
            return countries
        }
        return countries.filter { country in
            let searchTerms = searchText.lowercased()
            
            if let commonName = country.name?.common?.lowercased(),
               commonName.contains(searchTerms) {
                return true
            }
            
            if let translations = country.translations {
                for (_, translation) in translations {
                    if translation.common?.lowercased().contains(searchTerms) == true ||
                       translation.official?.lowercased().contains(searchTerms) == true {
                        return true
                    }
                }
            }
            
            return false
        }
    }
    
    func getPopulationRank(for country: CountryElement) -> Int {
        if let countryCode = country.cca2,
           let rank = populationRankings[countryCode] {
            return rank
        }
        
        let sortedCountries = countries.sorted {
            ($0.population ?? 0) > ($1.population ?? 0)
        }
        
        sortedCountries.enumerated().forEach { index, country in
            if let code = country.cca2 {
                populationRankings[code] = index + 1
            }
        }
        
        return populationRankings[country.cca2 ?? ""] ?? 0
    }
    
    func fetchCountries() {
        isLoading = true
        Task {
            await sessionManager.fetchDecodableData(from: Endpoint.baseURL) { (result: Result<[CountryElement], Error>) in
                self.isLoading = false
                switch result {
                case .success(let countries):
                    self.countries = countries.sorted { ($0.name?.common ?? "") < ($1.name?.common ?? "") }
                    self.calculatePopulationRankings()
                case .failure(let error):
                    self.error = error as? NetworkError
                }
            }
        }
    }
    
    func handleFavorite(for country: CountryElement) {
        guard let countryCode = country.cca2 else { return }
        
        if favorites.contains(countryCode) {
            favorites.remove(countryCode)
        } else {
            favorites.insert(countryCode)
        }
        
        UserDefaults.standard.set(Array(favorites), forKey: "favoriteCountries")
        UserDefaults.standard.synchronize()
    }
    
    func isFavorite(_ country: CountryElement) -> Bool {
        guard let countryCode = country.cca2 else { return false }
        return favorites.contains(countryCode)
    }
    
    //MARK: Private
    private let sessionManager = SessionManager.shared
    private var populationRankings: [String: Int] = [:]
    
    private func calculatePopulationRankings() {
        let sortedCountries = countries.sorted {
            ($0.population ?? 0) > ($1.population ?? 0)
        }
        
        populationRankings = Dictionary(
            uniqueKeysWithValues: sortedCountries.enumerated().compactMap { index, country in
                country.cca2.map { ($0, index + 1) }
            }
        )
    }
}
