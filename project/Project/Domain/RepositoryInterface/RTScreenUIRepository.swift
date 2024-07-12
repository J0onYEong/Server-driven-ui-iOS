//
//  RTScreenUIRepository.swift
//  Data
//
//  Created by 최재혁 on 7/11/24.
//

import Foundation
import RxSwift

public protocol RTScreenUIRepository {
    func getHomeRTScreenUI() -> Single<RTScreenVO>
}
