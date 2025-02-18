//
//  CountryElement+Extension.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

extension CountryElement {
    var flagEmoji: String {
        guard let cca2 = self.cca2 else { return "🏳️" }
        
        let base: UInt32 = 127397
        var emoji = ""
        
        for scalar in cca2.uppercased().unicodeScalars {
            if scalar.value >= 65 && scalar.value <= 90 {
                let regionalIndicator = UnicodeScalar(base + scalar.value)!
                emoji.append(String(regionalIndicator))
            }
        }
        
        return emoji
    }
}

extension CountryElement: Hashable {
    static func == (lhs: CountryElement, rhs: CountryElement) -> Bool {
        if let lhsCode = lhs.cca2, let rhsCode = rhs.cca2 {
            return lhsCode == rhsCode
        }
        return lhs.name?.common == rhs.name?.common
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cca2)
        hasher.combine(name?.common)
    }
}

extension CountryElement {
    func getFlagURL() -> URL? {
        guard let countryCode = cca2 else { return nil }
        let urlString = "\(Endpoint.imgURL)\(countryCode)/flat/64.png"
        return URL(string: urlString)
    }
}

extension CountryElement {
    static var mock: CountryElement {
        CountryElement(
            name: Name(
                common: "Finland",
                official: "Republic of Finland",
                nativeName: ["fin": Translation(official: "Suomen tasavalta", common: "Suomi")]
            ),
            tld: [".fi"],
            cca2: "FI",
            ccn3: "246",
            cca3: "FIN",
            independent: true,
            status: .officiallyAssigned,
            unMember: true,
            currencies: ["EUR": Currency(name: "Euro", symbol: "€")],
            idd: Idd(root: "+3", suffixes: ["58"]),
            capital: ["Helsinki"],
            altSpellings: ["FI", "Suomi", "Republic of Finland", "Suomen tasavalta"],
            region: .europe,
            languages: ["fin": "Finnish", "swe": "Swedish"],
            translations: [
                "fra": Translation(official: "République de Finlande", common: "Finlande"),
                "spa": Translation(official: "República de Finlandia", common: "Finlandia")
            ],
            latlng: [64.0, 26.0],
            landlocked: false,
            area: 338424.0,
            demonyms: Demonyms(
                eng: Eng(f: "Finnish", m: "Finnish"),
                fra: Eng(f: "Finlandaise", m: "Finlandais")
            ),
            flag: "🇫🇮",
            maps: Maps(
                googleMaps: "https://goo.gl/maps/HjgWDCNKRAYHrkMn8",
                openStreetMaps: "https://www.openstreetmap.org/relation/54224"
            ),
            population: 5530719,
            car: Car(signs: ["FIN"], side: .sideRight),
            timezones: ["UTC+02:00"],
            continents: [.europe],
            flags: Flags(
                png: "https://flagcdn.com/w320/fi.png",
                svg: "https://flagcdn.com/fi.svg",
                alt: "The flag of Finland has a white field with a large blue cross that extends to the edges of the field."
            ),
            coatOfArms: CoatOfArms(
                png: "https://mainfacts.com/media/images/coats_of_arms/fi.png",
                svg: "https://mainfacts.com/media/images/coats_of_arms/fi.svg"
            ),
            startOfWeek: .monday,
            capitalInfo: CapitalInfo(latlng: [60.17, 24.93]),
            cioc: "FIN",
            subregion: "Northern Europe",
            fifa: "FIN",
            borders: ["NOR", "SWE", "RUS"],
            gini: ["2018": 27.3],
            postalCode: PostalCode(format: "#####", regex: "^\\d{5}$")
        )
    }
}
