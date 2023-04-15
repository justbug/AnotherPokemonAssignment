//
//  ListCell.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import SnapKit
import UIKit

final class ListCell: UICollectionViewCell {
    private lazy var titleLabel = makeTitleLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        titleLabel.text = title
    }
}

// MARK: - Helper

private extension ListCell {
    func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
}
