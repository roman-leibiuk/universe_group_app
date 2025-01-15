//
//  SkillCell.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 14.01.2025.
//

import UIKit
import RxSwift

enum SkillCellType {
    case regular
    case deselect
    case checkmark
}

final class SkillCell: UITableViewCell {
    enum Constants {
        static let selectedIconName = "heart.fill"
        static let deselectedIconName = "heart"
        static let removeIconName = "minus.circle"
        
        static let defaultPadding = 16
        static let checkBoxSize = 24
    }
    
    let checkBoxButton = UIButton()
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private(set) var disposeBag = DisposeBag()
    private var type: SkillCellType = .regular {
        didSet {
            guard oldValue != type else { return }
            checkBoxButton.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(checkBoxLeftOffset)
            }
        }
    }
    
    private var checkBoxLeftOffset: Int {
        type == .regular
        ? -Constants.checkBoxSize
        : Constants.defaultPadding
    }
    
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
    
    func setType(_ type: SkillCellType, animated: Bool) {
        self.type = type
        guard animated else { return }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func configure(with model: SkillModel) {
        titleLabel.text = model.title.localized()
        descriptionLabel.text = model.description.localized()
        
        switch type {
        case .checkmark:
            let image = model.isSelected
            ? Constants.selectedIconName
            : Constants.deselectedIconName
            
            checkBoxButton.isHidden = false
            checkBoxButton.isEnabled = false
            checkBoxButton.tintColor = .systemBlue
            checkBoxButton.setImage(UIImage(systemName: image), for: .disabled)
            
        case .deselect:
            checkBoxButton.isHidden = false
            checkBoxButton.isEnabled = true
            checkBoxButton.tintColor = .systemRed
            checkBoxButton.setImage(UIImage(systemName: Constants.removeIconName), for: .normal)
            
        case .regular:
            checkBoxButton.isHidden = true
        }
    }
}

private extension SkillCell {
    func setupUI() {
        backgroundColor = .systemBackground
        selectionStyle = .none
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(checkBoxButton)
        
        containerStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.defaultPadding)
            $0.top.equalToSuperview().offset(Constants.defaultPadding)
            $0.bottom.equalToSuperview().offset(-Constants.defaultPadding)
        }

        checkBoxButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(-Constants.checkBoxSize)
            $0.trailing.equalTo(containerStackView.snp.leading).offset(-Constants.defaultPadding)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(Constants.checkBoxSize)
        }
        
        checkBoxButton.imageView?.snp.makeConstraints {
            $0.height.width.equalTo(Constants.checkBoxSize)
        }
    }
}
