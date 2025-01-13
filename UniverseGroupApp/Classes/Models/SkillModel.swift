//
//  SkillModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation

struct SkillModel {
    let title: String
    let description: String
    var isSelected: Bool = false
}

extension SkillModel {
    static var allSkills: [SkillModel] {
        [
            .init(title: "swiftTitle", description: "swiftDescription"),
            .init(title: "objectiveCTitle", description: "objectiveCDescription"),
            .init(title: "uikitTitle", description: "uikitDescription"),
            .init(title: "swiftUITitle", description: "swiftUIDescription"),
            .init(title: "coreDataTitle", description: "coreDataDescription"),
            .init(title: "combineTitle", description: "combineDescription"),
            .init(title: "rxswiftTitle", description: "rxswiftDescription"),
            .init(title: "gcdTitle", description: "gcdDescription"),
            .init(title: "operationQueuesTitle", description: "operationQueuesDescription"),
            .init(title: "storyboardsTitle", description: "storyboardsDescription"),
            .init(title: "autoLayoutTitle", description: "autoLayoutDescription"),
            .init(title: "coreAnimationTitle", description: "coreAnimationDescription"),
            .init(title: "networkingTitle", description: "networkingDescription"),
            .init(title: "alamofireTitle", description: "alamofireDescription"),
            .init(title: "unitTestingTitle", description: "unitTestingDescription"),
            .init(title: "uiTestingTitle", description: "uiTestingDescription"),
            .init(title: "debuggingTitle", description: "debuggingDescription"),
            .init(title: "gitTitle", description: "gitDescription"),
            .init(title: "cocoapodsTitle", description: "cocoapodsDescription"),
            .init(title: "swiftPackageManagerTitle", description: "swiftPackageManagerDescription"),
            .init(title: "jsonHandlingTitle", description: "jsonHandlingDescription"),
            .init(title: "restAPITitle", description: "restAPIDescription"),
            .init(title: "oauthTitle", description: "oauthDescription")
        ]
    }
}
