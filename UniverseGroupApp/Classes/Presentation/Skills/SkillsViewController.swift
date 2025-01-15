//
//  SkillsViewController.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

final class SkillsViewController: BaseViewController<SkillsViewModel> {
    enum Constants {
        static let navigationTitle = "skills"
        static let selectedIconName = "heart.fill"
        static let deselectedIconName = "heart.slash.fill"
        
        static let select = "select"
        static let cancel = "done"
        static let selectAll = "selectAll"
        static let deselectAll = "deselectAll"
    }
    
    private lazy var contentView = SkillsTableView()
    private lazy var rightBarButtonItem = UIBarButtonItem()
    private lazy var leftBarButtonItem = UIBarButtonItem()
    
    private var isCellAnimated = false
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

private extension SkillsViewController {
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
        
        leftBarButtonItem.title = Constants.selectAll.localized()
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
        ) {[weak self] _, model, cell in
            self?.configureCell(cell, with: model)
        }
        .disposed(by: disposeBag)
        
        contentView.tableView.rx.modelSelected(SkillModel.self)
            .subscribe { [weak self] model in
                guard let self, self.viewModel.isMultiSelected.value else { return }
                self.viewModel.onCellSelected(model: model)
            }
            .disposed(by: disposeBag)
    }
    
    func configureCell(_ cell: SkillCell, with model: SkillModel) {
        let cellType: SkillCellType = viewModel.isMultiSelected.value
        ? .checkmark
        : .regular
        cell.setType(cellType, animated: isCellAnimated)
        cell.configure(with: model)
    }
    
    func bindEmptyStateLabel() {
        viewModel.skills
            .map { !$0.isEmpty }
            .bind(to: contentView.emptyStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func bindBarButtonItems() {
        viewModel.isMultiSelected
            .skip(1)
            .do(onNext: { [weak self] isMultiSelected in
                self?.leftBarButtonItem.isHidden = !isMultiSelected
                self?.rightBarButtonItem.title = isMultiSelected
                ? Constants.cancel.localized()
                : Constants.select.localized()
                
                self?.isCellAnimated = true
            })
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.isCellAnimated = false
            })
            .disposed(by: disposeBag)
        
        viewModel.isAllSelected
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isAllSelected in
                self?.leftBarButtonItem.title = isAllSelected
                ? Constants.deselectAll.localized()
                : Constants.selectAll.localized()
            })
            .disposed(by: disposeBag)
        
        rightBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.viewModel.isMultiSelected.accept(!self.viewModel.isMultiSelected.value)
            })
            .disposed(by: disposeBag)
        
        leftBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onSelectedAll()
            })
            .disposed(by: disposeBag)
    }
}

extension SkillsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard !viewModel.isMultiSelected.value else { return nil}
        let skill = viewModel.skills.value[indexPath.row]
        let iconName = skill.isSelected
        ? Constants.deselectedIconName
        : Constants.selectedIconName
        
        let backgroundColor = skill.isSelected
        ? UIColor.systemRed
        : UIColor.systemBlue
        
        let action = UIContextualAction(style: .normal, title: nil) {[weak self] _, _, completion in
            self?.viewModel.onCellSelected(model: skill)
            completion(true)
        }
        
        action.image = UIImage(systemName: iconName)
        action.backgroundColor = backgroundColor
        
        return .init(actions: [action])
    }
}
