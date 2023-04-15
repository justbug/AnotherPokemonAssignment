//
//  FavoriteView.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import UIKit

final class FavoriteView: UIView {
    private lazy var favoriteButton = makeFavoriteButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper

private extension FavoriteView {
    @objc func favoriteButtonPressed() {

    }
}

// MARK: - Layout
private extension FavoriteView {
    func setupUI() {
        backgroundColor = .white
        addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func makeFavoriteButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        return button
    }
}
