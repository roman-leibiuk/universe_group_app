//
//  FavoriteSkillsService.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

protocol FavoriteSkillsService {
    var favoriteSkillsObservable: Observable<[SkillModel]> { get }
    func remove(favoriteSkill: SkillModel)
    func removeAll()
}
