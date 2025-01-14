//
//  SkillCell.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 14.01.2025.
//

import UIKit
import RxSwift

enum SkillCellType {
    case deselect
    case checkmark
}

final class SkillCell: UITableViewCell {
    enum Constants {
        static let selectedIconName = "checkmark.circle"
        static let deselectedIconName = "circle"
        static let removeIconName = "minus.circle"
        static let defaultPadding = 16
        static let rightButtonSize = 24
    }
    
    let rightButton = UIButton()
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private(set) var disposeBag = DisposeBag()
    private var type: SkillCellType = .checkmark
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(with model: SkillModel, type: SkillCellType) {
        titleLabel.text = model.title.localized()
        descriptionLabel.text = model.description.localized()
        
        switch type {
        case .checkmark:
            rightButton.isEnabled = false
            rightButton.tintColor = .systemBlue
            rightButton.setImage(
                model.isSelected
                ? UIImage(systemName: Constants.selectedIconName)
                : UIImage(systemName: Constants.deselectedIconName),
                for: .disabled
            )
            
        case .deselect:
            rightButton.isEnabled = true
            rightButton.tintColor = .systemRed
            rightButton.setImage(
                UIImage(systemName: Constants.removeIconName),
                for: .normal
            )
        }
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(rightButton)
        
        containerStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.defaultPadding)
            $0.top.equalToSuperview().offset(Constants.defaultPadding)
            $0.bottom.equalToSuperview().offset(-Constants.defaultPadding)
            $0.trailing.equalTo(rightButton.snp.leading).offset(-Constants.defaultPadding)
        }

        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.defaultPadding)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(Constants.rightButtonSize)
        }
        
        rightButton.imageView?.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.rightButtonSize)
        }
    }
}
