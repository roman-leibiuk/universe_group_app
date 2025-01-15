//
//  SplashViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation
import RxSwift

final class SplashViewModel: BaseViewModel {
    var transitionObservable: Observable<SplashTransition> {
        transitionSubject.asObservable()
    }
    
    var isLoading: PublishSubject<Bool> = .init()
    
    private let skillsFetchService: SkillsFetchService
    private let allSkillsService: AllSkillsService
    
    private var transitionSubject = PublishSubject<SplashTransition>()
    
    init(
        skillsFetchService: SkillsFetchService,
        allSkillsService: AllSkillsService
    ) {
        self.skillsFetchService = skillsFetchService
        self.allSkillsService = allSkillsService
    }
    
    override func onViewDidLoad() {
        super.onViewDidLoad()
        getData()
    }
}

private extension SplashViewModel {
    func getData() {
        isLoading.onNext(true)
        skillsFetchService.getSkills()
            .subscribe(onNext: { [unowned self] response in
                allSkillsService.update(skills: response)
                transitionSubject.onNext(.tabBar)
                isLoading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
