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
        static let selectAllIconName: String = "checkmark.rectangle.stack"
        static let deselectAllIconName: String = "rectangle.stack"
    }
    
    private let contentView = SkillsTableView()
    private let rightBarButtonItem = UIBarButtonItem()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
        setupUI()
        bind()
    }
}

private extension SkillsViewController {
    func setupUI() {
        configureTableView()
        configureNavigationBar()
    }
    
    func configureTableView() {
        contentView.tableView.register(
            SkillCell.self,
            forCellReuseIdentifier: SkillCell.description()
        )
    }
    
    func configureNavigationBar() {
        title = Constants.navigationTitle.localized()
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func bind() {
        viewModel.skills
            .observe(on: MainScheduler.instance)
            .bind(
                to: contentView.tableView.rx.items(
                    cellIdentifier: SkillCell.description(),
                    cellType: SkillCell.self
                )
            ) { _, model, cell in
                cell.configure(with: model, type: .checkmark)
            }
            .disposed(by: disposeBag)
        
        contentView.tableView.rx.modelSelected(SkillModel.self)
            .subscribe { [weak self] model in
                self?.viewModel.onCellSelected(model: model)
            }
            .disposed(by: disposeBag)
        
        viewModel.skills
            .observe(on: MainScheduler.instance)
            .map { !$0.isEmpty }
            .bind(to: contentView.emptyStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isSelectedAll
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSelectedAll in
                let iconName = isSelectedAll
                ? Constants.selectAllIconName
                : Constants.deselectAllIconName
                self?.rightBarButtonItem.image = UIImage(systemName: iconName)
            })
            .disposed(by: disposeBag)
        
        rightBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.onSelectedAll()
            })
            .disposed(by: disposeBag)
    }
}
