//
//  SkillModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation

struct SkillModel: Identifiable {
    let id: String
    let title: String
    let description: String
    var isSelected: Bool = false
}

extension SkillModel {
    static var allSkills: [SkillModel] {
        [
            .init(id: UUID().uuidString, title: "swiftTitle", description: "swiftDescription"),
            .init(id: UUID().uuidString, title: "objectiveCTitle", description: "objectiveCDescription"),
            .init(id: UUID().uuidString, title: "uikitTitle", description: "uikitDescription"),
            .init(id: UUID().uuidString, title: "swiftUITitle", description: "swiftUIDescription"),
            .init(id: UUID().uuidString, title: "coreDataTitle", description: "coreDataDescription"),
            .init(id: UUID().uuidString, title: "combineTitle", description: "combineDescription"),
            .init(id: UUID().uuidString, title: "rxswiftTitle", description: "rxswiftDescription"),
            .init(id: UUID().uuidString, title: "gcdTitle", description: "gcdDescription"),
            .init(id: UUID().uuidString, title: "operationQueuesTitle", description: "operationQueuesDescription"),
            .init(id: UUID().uuidString, title: "storyboardsTitle", description: "storyboardsDescription"),
            .init(id: UUID().uuidString, title: "autoLayoutTitle", description: "autoLayoutDescription"),
            .init(id: UUID().uuidString, title: "coreAnimationTitle", description: "coreAnimationDescription"),
            .init(id: UUID().uuidString, title: "networkingTitle", description: "networkingDescription"),
            .init(id: UUID().uuidString, title: "alamofireTitle", description: "alamofireDescription"),
            .init(id: UUID().uuidString, title: "unitTestingTitle", description: "unitTestingDescription"),
            .init(id: UUID().uuidString, title: "uiTestingTitle", description: "uiTestingDescription"),
            .init(id: UUID().uuidString, title: "debuggingTitle", description: "debuggingDescription"),
            .init(id: UUID().uuidString, title: "gitTitle", description: "gitDescription"),
            .init(id: UUID().uuidString, title: "cocoapodsTitle", description: "cocoapodsDescription"),
            .init(id: UUID().uuidString, title: "swiftPackageManagerTitle", description: "swiftPackageManagerDescription"),
            .init(id: UUID().uuidString, title: "jsonHandlingTitle", description: "jsonHandlingDescription"),
            .init(id: UUID().uuidString, title: "restAPITitle", description: "restAPIDescription"),
            .init(id: UUID().uuidString, title: "oauthTitle", description: "oauthDescription")
        ]
    }
}
