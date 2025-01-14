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
    
    private var transitionSubject = PublishSubject<SplashTransition>()
    private let skillsFetchService: SkillsFetchService
    private let allSkillsService: AllSkillsService
    
    init(
        skillsFetchService: SkillsFetchService,
        allSkillsService: AllSkillsService
    ) {
        self.skillsFetchService = skillsFetchService
        self.allSkillsService = allSkillsService
    }
    
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
