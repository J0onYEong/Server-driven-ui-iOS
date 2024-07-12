//
//  DefaultRTScreenRespository.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import Domain
import RxSwift

public class DefaultRTScreenRespository : RTScreenUIRepository {
    private let datasource : DefaultNetworkDataSource
    
    public init(datasource: DefaultNetworkDataSource = DefaultNetworkDataSource()) {
        self.datasource = datasource
    }
    
    public func getHomeRTScreenUI() -> Single<RTScreenVO> {
        let baseUrl = "https://s3.ap-northeast-2.amazonaws.com/api.swm-mobile.org/richtext.json"
        var urlRequest = URLRequest(url: URL(string: baseUrl)!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        let single : Single<RTResponseData> = datasource.request(urlRequest)
        return single.map{$0.responseData.toEntity()}
    }
}
