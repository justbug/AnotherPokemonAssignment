//
//  FavoriteCollectionViewController.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/15.
//

import UIKit

final class FavoriteCollectionViewController: UIViewController {
    private let viewModel: FavoriteCollectionViewModel

    init(viewModel: FavoriteCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
