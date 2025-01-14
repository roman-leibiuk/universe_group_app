//
//  AllSkillsService.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

protocol AllSkillsService {
    var skillsObservable: Observable<[SkillModel]> { get }
    
    func update(skills: [SkillModel])
    func toggleSelection(for skill: SkillModel)
    func setAllSkillsSelection(isSelected: Bool)
}

