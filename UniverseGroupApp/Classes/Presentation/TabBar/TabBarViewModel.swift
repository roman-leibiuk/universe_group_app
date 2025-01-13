//
//  TabBarViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

final class TabBarViewModel: ViewModel {
    private(set) lazy var transitionObservable: Observable<TabBarTransition> = transitionSubject.asObservable()
    private let transitionSubject = PublishSubject<TabBarTransition>()
}
