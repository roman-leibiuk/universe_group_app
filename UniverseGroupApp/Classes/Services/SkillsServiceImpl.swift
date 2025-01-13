//
//  SkillsServiceImpl.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

typealias SkillService = (SkillsFetchService & AllSkillsService & FavoriteSkillsService)

final class SkillsServiceImpl: SkillService {
    var skills: BehaviorSubject<[SkillModel]> = .init(value: [])
    var favoriteSkills: BehaviorSubject<[SkillModel]> = .init(value: [])
 
    func getSkills() -> Observable<[SkillModel]> {
        Observable
            .just(SkillModel.allSkills)
            .delay(.seconds(3), scheduler: MainScheduler.instance)
    }
}
