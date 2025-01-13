//
//  TabBarViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import RxSwift

final class TabBarViewModel: BaseViewModel {
    var transitionObservable: Observable<TabBarTransition> {
        transitionSubject.asObservable()
    }
    private let transitionSubject = PublishSubject<TabBarTransition>()
}
