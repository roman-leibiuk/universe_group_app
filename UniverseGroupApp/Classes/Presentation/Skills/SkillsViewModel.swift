//
//  SkillsViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

final class SkillsViewModel: ViewModel {
    private(set) lazy var transitionObservable: Observable<SkillsTransition> = transitionSubject.asObservable()
    private let transitionSubject = PublishSubject<SkillsTransition>()
}
