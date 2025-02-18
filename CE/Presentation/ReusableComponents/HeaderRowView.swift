//
//  HeaderRow.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import SwiftUI

struct HeaderRowView: View {
    let country: CountryElement
    let isFavorite: Bool
    let favoriteAction: () -> Void
    
    var body: some View {
        HStack {
            AsyncImage(url: country.getFlagURL()) { phase in
                switch phase {
                case .empty:
                    Color.secondary
                        .opacity(0.1)
                        .frame(width: 55, height: 45)
                case .success(let image):
                    image
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 50)
            
            Text(country.name?.nativeName?.values.first?.common ?? country.name?.common ?? Strings.notApplicable)
                .font(.title3)
            
            Spacer()
            
            Button(action: favoriteAction) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}
