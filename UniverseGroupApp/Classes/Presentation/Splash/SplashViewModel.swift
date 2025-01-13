//
//  SplashViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation
import RxSwift

final class SplashViewModel: ViewModel {
    private(set) lazy var transitionPublisher: Observable<SplashTransition> = transitionSubject.asObservable()
    private let transitionSubject = PublishSubject<SplashTransition>()
    
    func getData() {
        
    }
}
