//
//  InfoRow.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import SwiftUI

struct InfoRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
        }
        .padding(.vertical, 2)
    }
}
