//
//  ServerDrivenViewModel.swift
//  App
//
//  Created by 최재혁 on 7/4/24.
//

import Foundation
import Domain
import UIKit
import RxSwift
import RxCocoa

public protocol ServerDrivenInputProtocol {
    var viewDidLoad : PublishSubject<Void> { get }
}

public protocol ServerDrivenOutputProtocol {
    var cellInformation : Signal<ScreenVO> { get }
}

public protocol ServerDrivenProtocol : ServerDrivenInputProtocol, ServerDrivenOutputProtocol {
    
}

public class ServerDrivenViewModel : ServerDrivenProtocol {
    let screenUIRepository : ScreenUIRepository
    
    public init(screenUIRespository : ScreenUIRepository){
        self.screenUIRepository = screenUIRespository
        
        self.viewDidLoad = PublishSubject<Void>()
        self.cellInformation = viewDidLoad
            .flatMap {
                return screenUIRespository.getHomeScreenUI()
            }
            .asSignal(onErrorSignalWith: .empty())
    }
    
    public var viewDidLoad: PublishSubject<Void>
    public var cellInformation: Signal<ScreenVO>
}
