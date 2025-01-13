//
//  SkillsService.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

protocol SkillsService {
    func getSkills() -> Observable<[SkillModel]>
}
