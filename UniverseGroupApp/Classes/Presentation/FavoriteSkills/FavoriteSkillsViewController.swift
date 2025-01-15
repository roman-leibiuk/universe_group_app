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
        static let deselectedIconName = "heart.slash"
        
        static let select = "select"
        static let cancel = "done"
        static let removeAll = "removeAll"
    }
    
    private let contentView = SkillsTableView()
    private let rightBarButtonItem = UIBarButtonItem()
    private let leftBarButtonItem = UIBarButtonItem()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        bindBarButtonItems()
    }
    
    func configureTableView() {
        contentView.tableView.register(
            SkillCell.self,
            forCellReuseIdentifier: SkillCell.description()
        )
    }
    
    func configureNavigationBar() {
        title = Constants.navigationTitle.localized()
        
        rightBarButtonItem.title = Constants.select.localized()
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        leftBarButtonItem.tintColor = .systemRed
        leftBarButtonItem.title = Constants.removeAll.localized()
        leftBarButtonItem.isHidden = true
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func bindTableView() {
        contentView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            viewModel.isMultiSelected,
            viewModel.skills
        )
        .map { $1 }
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
        let cellType: SkillCellType = self.viewModel.isMultiSelected.value
        ? .deselect
        : .regular
        cell.configure(with: model, type: cellType)
        
        cell.checkBoxButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.removeSkill(model: model)
            })
            .disposed(by: cell.disposeBag)
    }
    
    func bindEmptyStateLabel() {
        viewModel.skills
            .map { !$0.isEmpty }
            .bind(to: contentView.emptyStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func bindBarButtonItems() {
        Observable.combineLatest(
            viewModel.isMultiSelected,
            viewModel.skills
        )
        .subscribe(onNext: { [weak self] isMultiSelected, skills in
            self?.leftBarButtonItem.isHidden = !isMultiSelected || skills.isEmpty
            self?.rightBarButtonItem.title = isMultiSelected
            ? Constants.cancel.localized()
            : Constants.select.localized()
        })
        .disposed(by: disposeBag)
        
        viewModel.skills
            .map { $0.isEmpty }
            .bind(to: rightBarButtonItem.rx.isHidden)
            .disposed(by: disposeBag)
        
        rightBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.viewModel.isMultiSelected.accept(!self.viewModel.isMultiSelected.value)
            })
            .disposed(by: disposeBag)
        
        leftBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onRemoveAll()
            })
            .disposed(by: disposeBag)
    }
}

extension FavoriteSkillsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let skill = self.viewModel.skills.value[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            self?.viewModel.removeSkill(model: skill)
            completion(true)
        }
        
        action.image = UIImage(systemName: Constants.deselectedIconName)
        return .init(actions: [action])
    }
}
