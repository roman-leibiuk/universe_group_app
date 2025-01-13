//
//  SkillsViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

final class SkillsViewModel: BaseViewModel {
    var transitionObservable: Observable<SkillsTransition> {
        transitionSubject.asObservable()
    }
    private let transitionSubject = PublishSubject<SkillsTransition>()
    private let allSkillsService: AllSkillsService
    
    init(allSkillsService: AllSkillsService) {
        self.allSkillsService = allSkillsService
    }
}
