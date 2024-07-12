//
//  NetworkDataStore.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import RxSwift
import Alamofire

public class DefaultNetworkDataSource {
    
    public init() { }
    
    public func request<Response: Decodable>(_ urlRequest: URLRequest) -> Single<Response> {
        
        // Alamofire 요청
        return Single.create { single in
            
            let dataRequest = AF
                .request(urlRequest)
                .responseDecodable(of: Response.self) { result in
                    
                    switch result.result {
                    case .success(let response):
                        single(.success(response))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}


