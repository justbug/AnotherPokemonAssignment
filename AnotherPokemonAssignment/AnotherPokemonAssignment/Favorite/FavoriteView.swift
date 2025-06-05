//
//  FavoriteView.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import Combine
import UIKit

final class FavoriteView: UIView {
    private let viewModel: FavoriteViewModel
    private lazy var favoriteButton = makeFavoriteButton()
    private var cancelBag = Set<AnyCancellable>()

    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload(id: String, name: String) {
        viewModel.setID(id, name: name)
        viewModel.reloadFavorite(id: id)
    }
}

// MARK: - Helper

private extension FavoriteView {
    @objc func favoriteButtonPressed(_ button: UIButton) {
        let newState = !button.isSelected
        viewModel.setIsFavorite(newState)
    }

    func binding() {
        NotificationCenter.default
            .publisher(for: .didFavorite)
            .compactMap { $0.userInfo?[FavoriteUserInfo.key] as? FavoriteUserInfo }
            .sink { [weak self] userInfo in
                guard let self = self else { return }
                self.viewModel.shouldUpdate(userInfo: userInfo)
            }.store(in: &cancelBag)

        viewModel.$isFavorite
            .sink { [weak self] isFavorite in
                self?.favoriteButton.isSelected = isFavorite
            }.store(in: &cancelBag)
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
