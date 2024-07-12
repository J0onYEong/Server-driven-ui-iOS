//
//  RTProjectTests.swift
//  ProjectTests
//
//  Created by 최재혁 on 7/12/24.
//

import Foundation
import Alamofire
import XCTest
@testable import Data

final class RTProjectTests : XCTestCase {
    func testData() {
        //expectation 생성
        let expectation = self.expectation(description: "Request should complete")
        
        //URL URLRequest
        let baseUrl = "https://s3.ap-northeast-2.amazonaws.com/api.swm-mobile.org/richtext.json"
        var urlRequest = URLRequest(url: URL(string: baseUrl)!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        //Alamofire 요청
        AF
            .request(urlRequest)
            .responseDecodable(of: RTResponseData.self) { response in
                //응답 핸들링
                if let result = try? response.result.get() {
                    let screenVO = result.responseData.toEntity()
                    screenVO.contents.forEach {
                        print($0, terminator: "\n\n")
                    }
                } else {
                    XCTFail("Request failed")
                }
                
                //expectation을 만족시킴
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRepository() {
        let expectation = self.expectation(description: "Repository should complete")
        
        let _ = DefaultRTScreenRespository()
            .getHomeRTScreenUI()
            .catch({ error in
                XCTFail("Request failed \(error.localizedDescription)")
                return .never()
            })
            .subscribe { RTScreenVO in
                print(RTScreenVO)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
