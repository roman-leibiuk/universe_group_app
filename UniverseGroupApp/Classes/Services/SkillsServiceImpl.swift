//
//  SkillsServiceImpl.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

final class SkillsServiceImpl: SkillsService {
 
    func getSkills() -> Observable<[SkillModel]> {
        Observable
            .just(SkillModel.allSkills)
            .delay(.seconds(3), scheduler: MainScheduler.instance)
    }
}
    
