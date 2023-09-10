//
//  StopError.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-09-09.
//

import Foundation


enum StopError: Error, LocalizedError{
    case invalidURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String?{
        switch self{
        case .invalidURL:
            return "The URL is invalid."
        case .serverError:
            return "There was an error with the server retreiving the stop. Please try again."
        case .invalidData:
            return "The data is invalid."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
