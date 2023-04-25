//
//  StopsRequest.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation

final class TLRequest{
    
    private struct Constants{
        static let baseUrl = "https://api.translink.ca/rttiapi/v1"
    }
    
    private let endpoint: TLEndpoint
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]

    // Constructed url for the API request
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    
    /*
     Construct Request
     Parameters:
     - endpoint: Target endpoint
     - pathComponents: Collection of path components
     - queryParameters: Collection of query parameters
     */
    public init(
        endpoint: TLEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ){
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    func stopRequest(_ stopID: String) -> TLRequest{
        let request = TLRequest(
            endpoint: .stops,
            pathComponents: [stopID],
            queryParameters: [
                URLQueryItem(name: "apikey", value: apiKey)
            ])
        
        return request
    }
    
    func estimateRequest(_ stopID: String) -> TLRequest{
        let request = TLRequest(
            endpoint: .stops,
            pathComponents: [stopID, "estimates"],
            queryParameters: [
                URLQueryItem(name: "apikey", value: apiKey)
            ]
        )
        
        return request
    }
}

// https://api.translink.ca/rttiapi/v1/stops/55612?apikey=[APIKey]

extension TLRequest {
    static let stopsRequest = TLRequest(
        endpoint: .stops,
        pathComponents: ["58946"],
        queryParameters: [
            URLQueryItem(name: "apikey", value: "apikey")
        ])
}
