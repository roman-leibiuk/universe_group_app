//
//  SkillsViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

final class FavoriteSkillsViewModel: ViewModel {
    private(set) lazy var transitionObservable: Observable<FavoriteSkillsTransition> = transitionSubject.asObservable()
    private let transitionSubject = PublishSubject<FavoriteSkillsTransition>()
}
