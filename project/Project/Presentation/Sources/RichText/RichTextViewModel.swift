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


extension RTScreenVO {
    
    static var mockData: RTScreenVO {
        .init(
            screenName: "Home",
            contents: [
                ViewContentVO(
                    viewType: "BViewType",
                    content: [
                        TitleContentVO(content: "This is B ViewType")
                    ]
                ),
                ViewContentVO(
                    viewType: "AViewType",
                    content: [
                        TitleContentVO(content: "This is A ViewType"),
                        IconContentVO(
                            imageUrl: URL(string: "https://avatars.githubusercontent.com/u/103282546?s=200&v=4")!
                        )
                    ]
                ),
                ViewContentVO(
                    viewType: "RichViewType",
                    content: [
                        TitleContentVO(content: "This is RichText ViewType"),
                        RichTextContentVO(
                            content: [
                                RichTextContentVO.RTTextVO(
                                    text: "이것은",
                                    fontSize: 14,
                                    background: "clear"
                                ),
                                RichTextContentVO.RTTextVO(
                                    text: "새로운",
                                    fontSize: 16,
                                    background: "clear"
                                ),
                                RichTextContentVO.RTTextVO(
                                    text: "Rich Text",
                                    fontSize: 24,
                                    background: "yellow"
                                ),
                                RichTextContentVO.RTTextVO(
                                    text: "ViewType",
                                    fontSize: 30,
                                    background: "red"
                                ),
                                RichTextContentVO.RTTextVO(
                                    text: "어떻게 구현할수 있을까요?",
                                    fontSize: 24,
                                    background: "clear",
                                    textStyle: [
                                        "underline"
                                    ]
                                ),
                                RichTextContentVO.RTImageVO(
                                    url: URL(string: "https://img.icons8.com/?size=512&id=63684&format=png")!,
                                    width: 24.0,
                                    height: 24.0
                                )
                            ]
                        )
                    ]
                )
            ]
        )
    }
}
