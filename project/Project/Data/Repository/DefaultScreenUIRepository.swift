//
//  DefaultScreenUIRepository.swift
//  Data
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import Domain
import RxSwift

public class DefaultScreenUIRepository: ScreenUIRepository {
    
    private let dataSoruce: DefaultNetworkDataSource
    
    public init(dataSoruce: DefaultNetworkDataSource = DefaultNetworkDataSource()) {
        self.dataSoruce = dataSoruce
    }
    
    public func getHomeScreenUI() -> Single<ScreenVO> {
        
        // URL과 URLRequest 설정
        let baseUrl = "https://s3.ap-northeast-2.amazonaws.com/api.swm-mobile.org/server-driven-viewtype.json"
        var urlRequest = URLRequest(url: URL(string: baseUrl)!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        let single: Single<ScreenDTO> = dataSoruce.request(urlRequest)
        
        return single.map { $0.toEntity() }
    }
}
