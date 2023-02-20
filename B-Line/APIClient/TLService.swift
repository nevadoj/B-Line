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
    
    enum TLServiceError: Error{
        case failedToCreateRequest
        case failedToGetData
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
        completion: @escaping (Result<T, Error>) -> Void
    ){
     
        guard let urlRequest = self.request(from: request) else{
            completion(.failure(TLServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(TLServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do{
//                let json = try JSONSerialization.jsonObject(with: data)
                
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from tlRequest: TLRequest) -> URLRequest? {
        guard let url = tlRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = tlRequest.httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
