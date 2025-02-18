//
//  Endpoint.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

enum ConfigurationError: Error {
    case missingKey, invalidValue
}

struct Configuration {
    static func value<T>(for key: String) throws -> T {
        guard let path = Bundle.main.path(forResource: "config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            throw ConfigurationError.missingKey
        }
        
        guard let value = dict[key] as? T else {
            throw ConfigurationError.invalidValue
        }
        
        return value
    }
}

struct Endpoint {
    static var baseURL: String {
        (try? Configuration.value(for: "BASE_URL")) ?? ""
    }
    
    static var imgURL: String {
        (try? Configuration.value(for: "IMG_URL")) ?? ""
    }
}
