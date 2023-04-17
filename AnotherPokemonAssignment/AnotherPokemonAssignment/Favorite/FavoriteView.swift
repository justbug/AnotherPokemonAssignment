//
//  FavoriteView.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import UIKit

final class FavoriteView: UIView {
    private let viewModel: FavoriteViewModel
    private lazy var favoriteButton = makeFavoriteButton()

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload(id: String, name: String) {
        viewModel.setID(id, name: name)
        favoriteButton.isSelected = viewModel.getIsFavorite(id: id)
    }
}

// MARK: - Helper

private extension FavoriteView {
    @objc func favoriteButtonPressed(_ button: UIButton) {
        button.isSelected.toggle()
        viewModel.setIsFavorite(button.isSelected)
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