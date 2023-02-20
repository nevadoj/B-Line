//
//  TLService.swift
//  B-Line
//
//  Created by Joseph Nevado on 2023-02-19.
//

import Foundation


final class TLService{
    
    static let shared = TLService()
    
    private init() {
        
    }
    
    /*
     Parameters:
     - request: Request instance
     - type: The type of object we expect to get back 
     - completion: Callback with data or error
     */
    public func execute<T: Codable>(
        _ request: TLRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void){
        
    }
    
}
