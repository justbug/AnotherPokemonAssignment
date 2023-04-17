//
//  ListViewController.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/13.
//

import Combine
import UIKit

final class ListViewController: UIViewController {
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Section, Pokemon>
    fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>

    private lazy var collectionView = makeCollectionView()
    private lazy var dataSource = makeDataSource()
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
        fetchList()
    }
}

// MARK: - Helper

private extension ListViewController {
    enum Section {
        case main
    }

    func binding() {
        viewModel.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.title = title
            }
            .store(in: &cancelBag)

        viewModel.$pokemons
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemons in
                self?.reload(pokemons)
            }
            .store(in: &cancelBag)

        NotificationCenter.default
            .publisher(for: .didFavorite)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.handleDidFavoriteNotification()
            }.store(in: &cancelBag)
    }

    func fetchList() {
        viewModel.fetchList()
    }

    func reload(_ pokemons: [Pokemon]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(pokemons, toSection: .main)
        dataSource.apply(snapshot)
    }
}

// MARK: -

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(viewModel: .init(id: viewModel.pokemons[indexPath.item].id))
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Layout

private extension ListViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCompositionalLayout()
        )
        collectionView.backgroundColor = .white
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: "ListCell")
        collectionView.delegate = self
        return collectionView
    }

    func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, pokemon in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath)
            (cell as? ListCell)?.configure(title: pokemon.name, id: pokemon.id)
            return cell
        }
    }

    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(40)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            return section
        }
    }
}
