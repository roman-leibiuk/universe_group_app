//
//  SkillsViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift
import RxRelay

final class SkillsViewModel: BaseViewModel {
    private let allSkillsService: AllSkillsService
    
    private(set) var skills: BehaviorRelay<[SkillModel]> = .init(value: [])
    private(set) var isAllSelected: BehaviorRelay<Bool> = .init(value: false)
    private(set) var isMultiSelected: BehaviorRelay<Bool> = .init(value: false)
    
    init(allSkillsService: AllSkillsService) {
        self.allSkillsService = allSkillsService
    }
    
    override func onViewDidLoad() {
        super.onViewDidLoad()
        
        allSkillsService.skillsObservable
            .bind(to: skills)
            .disposed(by: disposeBag)
        
        allSkillsService.skillsObservable
            .map { $0.allSatisfy { $0.isSelected } }
            .bind(to: isAllSelected)
            .disposed(by: disposeBag)
    }
    
    override func onViewWillDisappear() {
        super.onViewWillDisappear()
        isMultiSelected.accept(false)
    }
    
    func onCellSelected(model skill: SkillModel) {
        allSkillsService.toggleSelection(for: skill)
    }
    
    func onSelectedAll() {
        let isSelected = !isAllSelected.value
        allSkillsService.setAllSkillsSelection(isSelected: isSelected)
    }
}
