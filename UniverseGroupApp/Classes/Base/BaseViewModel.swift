//
//  BaseViewModel.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 15.01.2025.
//

import Foundation
import RxSwift

class BaseViewModel: ViewModel {
    let disposeBag = DisposeBag()
    
    func onViewDidLoad() {}
    func onViewWillDisappear() {}
}
