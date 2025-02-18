//
//  Error.swift
//  CE
//
//  Created by automata on 18/02/2025.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case networkRequestFailed(statusCode: Int)
    case decodingError(Error)
    case generalNetworkError(Error)
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL."
        case .networkRequestFailed(let statusCode):
            return "Network request failed with status code \(statusCode)."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .generalNetworkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
