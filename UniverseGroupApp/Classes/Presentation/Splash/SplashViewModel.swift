//
//  SplashViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation
import RxSwift

final class SplashViewModel: ViewModel {
    private(set) lazy var transitionObservable: Observable<SplashTransition> = transitionSubject.asObservable()
    private let transitionSubject = PublishSubject<SplashTransition>()
    private let skillsService: SkillsService
    private let disposeBag = DisposeBag()
    
    init(skillsService: SkillsService) {
        self.skillsService = skillsService
    }
    
    func getData() {
        skillsService.getSkills().subscribe(onNext: {[weak self] response in
            self?.transitionSubject.onNext(.tabBar)
        })
        .disposed(by: disposeBag)
    }
}
