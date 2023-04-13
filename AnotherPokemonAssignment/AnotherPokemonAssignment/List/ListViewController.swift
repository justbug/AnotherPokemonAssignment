//
//  ListViewController.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Combine
import UIKit

final class ListViewController: UIViewController {
    private let viewModel: ListViewModel
    private var cancelBag = Set<AnyCancellable>()

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
    }
}

private extension ListViewController {
    func setupUI() {
        view.backgroundColor = .white
    }

    func binding() {
        viewModel.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancelBag)
    }
}
