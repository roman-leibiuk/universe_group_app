//
//  AllSkillsService.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

protocol AllSkillsService {
    var skills: BehaviorSubject<[SkillModel]> { get set }
}

