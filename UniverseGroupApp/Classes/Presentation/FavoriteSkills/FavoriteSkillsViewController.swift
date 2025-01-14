//
//  SkillsViewController.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

final class FavoriteSkillsViewController: BaseViewController<FavoriteSkillsViewModel> {
    enum Constants {
        static let navigationTitle = "favoriteSkills"
        static let removeAllIconName: String = "rectangle.stack.badge.minus"
    }
    
    private let contentView = SkillsTableView()
    private let rightBarButtonItem = UIBarButtonItem()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.onViewDidLoad()
        bindViewModel()
    }
}

private extension FavoriteSkillsViewController {
    func setupUI() {
        configureTableView()
        configureNavigationBar()
    }
    
    func bindViewModel() {
        bindTableView()
        bindEmptyStateLabel()
        bindRightBarButtonItem()
    }
    
    func configureTableView() {
        contentView.tableView.register(
            SkillCell.self,
            forCellReuseIdentifier: SkillCell.description()
        )
    }
    
    func configureNavigationBar() {
        title = Constants.navigationTitle.localized()
        rightBarButtonItem.tintColor = .systemRed
        rightBarButtonItem.image = UIImage(systemName: Constants.removeAllIconName)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func bindTableView() {
        viewModel.skills
            .observe(on: MainScheduler.instance)
            .bind(
                to: contentView.tableView.rx.items(
                    cellIdentifier: SkillCell.description(),
                    cellType: SkillCell.self
                )
            ) { [weak self] _, model, cell in
                self?.configureCell(cell, with: model)
            }
            .disposed(by: disposeBag)
    }
    
    func configureCell(_ cell: SkillCell, with model: SkillModel) {
        cell.configure(with: model, type: .deselect)
        
        cell.rightButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.removeSkill(model: model)
            })
            .disposed(by: cell.disposeBag)
    }
    
    func bindEmptyStateLabel() {
        viewModel.skills
            .observe(on: MainScheduler.instance)
            .map { !$0.isEmpty }
            .bind(to: contentView.emptyStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func bindRightBarButtonItem() {
        viewModel.skills
            .observe(on: MainScheduler.instance)
            .map { $0.isEmpty }
            .bind(to: rightBarButtonItem.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        rightBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onRemoveAll()
            })
            .disposed(by: disposeBag)
    }
}
