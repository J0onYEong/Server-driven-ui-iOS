//
//  RichTextViewModel.swift
//  Presentation
//
//  Created by choijunios on 7/12/24.
//

import Foundation
import Domain
import Data
import RxSwift
import RxCocoa

public class RichTextViewModel {
    
    let repository: RTScreenUIRepository
    
    let voPublisher: PublishRelay<RTScreenVO> = .init()
    
    let disposeBag = DisposeBag()
    
    public init(repository: RTScreenUIRepository) {
        self.repository = repository
    }
    
    func getData() {
        
        repository
            .getHomeRTScreenUI()
            .subscribe(
                onSuccess: { [weak self] vo in
                    
                    self?.voPublisher.accept(vo)
                },
                onFailure: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
            
    }
    
}

public class ViewTypeCellViewModel {
    
    let vo: ViewContentVO
    
    init(vo: ViewContentVO) {
        self.vo = vo
    }
    
    func getContents() -> [ViewTypeContentable] { vo.content }
}
