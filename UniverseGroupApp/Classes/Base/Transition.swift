//
//  Transition.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

protocol Transition {}

struct Module<T: Transition, V: UIViewController> {
    let viewController: V
    let transitionPublisher: Observable<T>
}
