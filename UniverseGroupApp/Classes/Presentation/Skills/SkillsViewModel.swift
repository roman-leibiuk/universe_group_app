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
    private(set) var isSelectedAll: BehaviorRelay<Bool> = .init(value: false)
    
    init(allSkillsService: AllSkillsService) {
        self.allSkillsService = allSkillsService
    }
    
    func onViewDidLoad() {
        allSkillsService.skills
            .bind(to: skills)
            .disposed(by: disposeBag)
        
        allSkillsService.skills
            .map { $0.allSatisfy { $0.isSelected } }
            .bind(to: isSelectedAll)
            .disposed(by: disposeBag)
    }
    
    func onCellSelected(model skill: SkillModel) {
        let updateSkills = skills.value.map {
            guard $0.id == skill.id else {
                return $0
            }
            var editedItem = $0
            editedItem.isSelected.toggle()
            return editedItem
        }
        
        allSkillsService.skills.onNext(updateSkills)
    }
    
    func onSelectedAll() {
        let isSelectedAll = isSelectedAll.value
        let updateSkills = skills.value.map {
            var editedItem = $0
            editedItem.isSelected = !isSelectedAll
            
            return editedItem
        }
        
        allSkillsService.skills.onNext(updateSkills)
    }
}
