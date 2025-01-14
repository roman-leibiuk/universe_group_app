//
//  SkillsViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift
import RxRelay

final class FavoriteSkillsViewModel: BaseViewModel {
    var transitionObservable: Observable<FavoriteSkillsTransition> {
        transitionSubject.asObservable()
    }
    private let transitionSubject = PublishSubject<FavoriteSkillsTransition>()
    private let favoriteSkillsService: FavoriteSkillsService
    
    private(set) var skills: BehaviorRelay<[SkillModel]> = .init(value: [])
    private(set) var isAllRemoved: BehaviorRelay<Bool> = .init(value: false)
    
    init(favoriteSkillsService: FavoriteSkillsService) {
        self.favoriteSkillsService = favoriteSkillsService
    }
    
    func onViewDidLoad() {
        favoriteSkillsService.favoriteSkillsObservable
            .bind(to: skills)
            .disposed(by: disposeBag)
    }
    
    func removeSkill(model skill: SkillModel) {
        favoriteSkillsService.remove(favoriteSkill: skill)
    }
    
    func onRemoveAll() {
        favoriteSkillsService.removeAll()
    }
}
