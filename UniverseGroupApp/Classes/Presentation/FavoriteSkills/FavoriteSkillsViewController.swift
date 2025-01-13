//
//  SkillsViewController.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import Foundation

final class FavoriteSkillsViewController: BaseViewController<FavoriteSkillsViewModel> {
    private let contentView = FavoriteSkillsView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
