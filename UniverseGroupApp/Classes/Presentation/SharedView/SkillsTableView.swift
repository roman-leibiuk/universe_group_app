//
//  SkillsTableView.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift
import SnapKit

final class SkillsTableView: UIView {
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.allowsMultipleSelection = true
        tableView.backgroundView = emptyStateLabel
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    private(set) lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "emptyStateTitle".localized()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SkillsTableView {
    func setupUI() {
        backgroundColor = .white
        addSubview(tableView)
        addSubview(emptyStateLabel)
        configureTableView()
    }
    
    func configureTableView() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
