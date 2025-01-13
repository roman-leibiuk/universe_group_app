//
//  AppContainerImpl.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation

final class AppContainerImpl: AppContainer {
    var skillsService: SkillsService
    
    init() {
        self.skillsService = SkillsServiceImpl()
    }
}
