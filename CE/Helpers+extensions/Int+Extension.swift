//
//  Int+Extension.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

extension Int {
    var ordinalized: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
