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
    private lazy var favoriteView = makeFavoriteView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, id: String) {
        titleLabel.text = title
        favoriteView.reload(id: id, name: title)
    }
}

// MARK: - Helper

private extension ListCell {
    @objc func favoriteButtonPressed() {

    }
}

// MARK: - Layout

private extension ListCell {
    func setupUI() {
        contentView.backgroundColor = .white
        [titleLabel, favoriteView].forEach(contentView.addSubview)

        titleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(8)
            make.trailing.lessThanOrEqualTo(favoriteView.snp.leading).offset(-8)
        }

        favoriteView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(35)
        }
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }

    func makeFavoriteView() -> FavoriteView {
        let view = FavoriteView(viewModel: .init(store: userDefaultsStore))
        return view
    }
}
