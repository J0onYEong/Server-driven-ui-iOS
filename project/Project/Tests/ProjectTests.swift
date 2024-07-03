import Foundation
import Alamofire
import XCTest
@testable import Data

final class ProjectTests: XCTestCase {
    func testData() {
        
        // Expectation 생성
        let expectation = self.expectation(description: "Request should complete")
        
        // URL과 URLRequest 설정
        let baseUrl = "https://s3.ap-northeast-2.amazonaws.com/api.swm-mobile.org/server-driven-viewtype.json"
        var urlRequest = URLRequest(url: URL(string: baseUrl)!)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "GET"
        
        // Alamofire 요청
        AF
            .request(urlRequest)
            .responseDecodable(of: ScreenDTO.self) { response in
                // 응답 핸들링
                if let result = try? response.result.get() {
                    
                    let screenVO = result.toEntity()
                    
                    screenVO.contents.forEach {
                        print($0, terminator: "\n\n")
                    }
                    
                } else {
                    XCTFail("Request failed")
                }
                
                // Expectation을 만족시킴
                expectation.fulfill()
            }
        
        // Expectation을 기다림
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRepository() {
        
        // Expectation 생성
        let expectation = self.expectation(description: "Repository should complete")
        
        let _ = DefaultScreenUIRepository()
            .getHomeScreenUI()
            .catch({ error in
                
                XCTFail("Request failed \(error.localizedDescription)")
                
                return .never()
            })
            .subscribe { screenVO in
                
                print(screenVO)
                
                expectation.fulfill()
            }
            
        // Expectation을 기다림
        waitForExpectations(timeout: 10, handler: nil)
    }
}
