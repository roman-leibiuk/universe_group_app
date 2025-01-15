//
//  SkillsServiceImpl.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift
import RxRelay

typealias SkillService = (SkillsFetchService & AllSkillsService & FavoriteSkillsService)

final class SkillsServiceImpl: SkillService {
    var skillsObservable: Observable<[SkillModel]> { skillsBehaviorRelay.asObservable() }
    var favoriteSkillsObservable: Observable<[SkillModel]> { favoriteSkillsBehaviorRelay.asObservable() }
    
    private var skillsBehaviorRelay: BehaviorRelay<[SkillModel]> = .init(value: [])
    private var favoriteSkillsBehaviorRelay: BehaviorRelay<[SkillModel]> = .init(value: [])
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.skillsBehaviorRelay
            .map { $0.filter(\.isSelected) }
            .bind(to: favoriteSkillsBehaviorRelay)
            .disposed(by: disposeBag)
    }
}

// MARK: - SkillsFetchService methods
extension SkillsServiceImpl {
    func getSkills() -> Observable<[SkillModel]> {
        Observable
            .just(SkillModel.allSkills)
            .delay(.seconds(3), scheduler: MainScheduler.instance)
    }
}

// MARK: - AllSkillsService methods
extension SkillsServiceImpl {
    func update(skills: [SkillModel]) {
        skillsBehaviorRelay.accept(skills)
    }
    
    func toggleSelection(for skill: SkillModel) {
        let updateSkills = skillsBehaviorRelay.value.map {
            guard $0.id == skill.id else {
                return $0
            }
            var editedItem = $0
            editedItem.isSelected.toggle()
            
            return editedItem
        }
        
        skillsBehaviorRelay.accept(updateSkills)
    }
    
    func setAllSkillsSelection(isSelected: Bool) {
        let updateSkills = skillsBehaviorRelay.value.map {
            var editedItem = $0
            editedItem.isSelected = isSelected
            
            return editedItem
        }
        
        skillsBehaviorRelay.accept(updateSkills)
    }
}

// MARK: - FavoriteSkillsService methods
extension SkillsServiceImpl {
    func remove(favoriteSkill: SkillModel) {
        toggleSelection(for: favoriteSkill)
    }
    
    func removeAll() {
        setAllSkillsSelection(isSelected: false)
    }
}
