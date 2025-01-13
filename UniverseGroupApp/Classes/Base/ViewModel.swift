//
//  ViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation
import RxSwift

protocol ViewModel { }

class BaseViewModel: ViewModel {
    let disposeBag = DisposeBag()
}
