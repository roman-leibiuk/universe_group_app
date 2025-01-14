//
//  SkillsViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift
import RxRelay

final class SkillsViewModel: BaseViewModel {
    var transitionObservable: Observable<SkillsTransition> {
        transitionSubject.asObservable()
    }
    
    private let transitionSubject = PublishSubject<SkillsTransition>()
    private let allSkillsService: AllSkillsService
    
    private(set) var skills: BehaviorRelay<[SkillModel]> = .init(value: [])
    private(set) var isAllSelected: BehaviorRelay<Bool> = .init(value: false)
    
    init(allSkillsService: AllSkillsService) {
        self.allSkillsService = allSkillsService
    }
    
    func onViewDidLoad() {
        allSkillsService.skillsObservable
            .bind(to: skills)
            .disposed(by: disposeBag)
        
        allSkillsService.skillsObservable
            .map { $0.allSatisfy { $0.isSelected } }
            .bind(to: isAllSelected)
            .disposed(by: disposeBag)
    }
    
    func onCellSelected(model skill: SkillModel) {
        allSkillsService.toggleSelection(for: skill)
    }
    
    func onSelectedAll() {
        let isSelected = !isAllSelected.value
        allSkillsService.setAllSkillsSelection(isSelected: isSelected)
    }
}
