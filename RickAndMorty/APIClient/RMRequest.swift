//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Ubaka Ngene on 02/01/2023.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseurl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    
    /// Paths components for API,  if any
    private let pathComponents: Set<String>
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Computed and constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Constructed url for API in string format
    private var urlString: String {
        var string = Constants.baseurl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            // name=value&name=value
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        
        return string
    }
    
    /// Desired http method
    public let httpMethod = "Get"
    
    // Mark: - Public
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of  query parameters
    public init(
            endpoint: RMEndpoint,
            pathComponents: Set<String> = [],
            queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
