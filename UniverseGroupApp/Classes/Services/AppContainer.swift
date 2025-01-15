//
//  AppContainerImpl.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation

protocol AppContainer: AnyObject {
    var skillsFetchService: SkillsFetchService { get }
    var allSkillsService: AllSkillsService { get }
    var favoriteSkillsService: FavoriteSkillsService { get }
}

final class AppContainerImpl: AppContainer {
    var skillsFetchService: SkillsFetchService
    var allSkillsService: AllSkillsService
    var favoriteSkillsService: FavoriteSkillsService
    
    init() {
        let service = SkillsServiceImpl()
        self.skillsFetchService = service
        self.allSkillsService = service
        self.favoriteSkillsService = service
    }
}
