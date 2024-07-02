//
//  ScreenUIRepository.swift
//  Domain
//
//  Created by choijunios on 7/2/24.
//

import Foundation
import RxSwift

public protocol ScreenUIRepository {
    
    func getHomeScreenUI() -> Single<ScreenVO>
}
