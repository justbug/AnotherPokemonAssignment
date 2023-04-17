//
//  DetailViewController.swift
//  AnotherPokemonAssignment
//
//  Created by Mark Chen on 2023/4/17.
//

import Combine
import Nuke
import UIKit

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private lazy var scrollView = makeScrollView()
    private lazy var imageView = makeImageView()
    private lazy var idLabel = makeLabel()
    private lazy var heightLabel = makeLabel()
    private lazy var weightLabel = makeLabel()
    private lazy var typeLabel = makeLabel()
    private var cancelBag = Set<AnyCancellable>()

    init(viewModel: DetailViewModel) {
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
        viewModel.fetchDetail()
    }

    deinit {
        print("DetailViewController deinit")
    }
}

// MARK: - Helper

private extension DetailViewController {
    func binding() {
        let shared: AnyPublisher<DetailModel, Never> = viewModel.$detail
            .compactMap({ $0 })
            .share()
            .eraseToAnyPublisher()

        shared
            .compactMap { $0.imageURL }
            .map { ImagePipeline.shared.imagePublisher(with: $0) }
            .flatMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { [weak self] response in
                self?.imageView.image = response.image
            })
            .store(in: &cancelBag)

        shared
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] detail in
                self?.idLabel.text = detail.idText
                self?.heightLabel.text = detail.heightText
                self?.weightLabel.text = detail.weightText
                self?.typeLabel.text = detail.typeText
            })
            .store(in: &cancelBag)
    }
}

// MARK: - Layout

private extension DetailViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        let contentView = makeContentView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        return scrollView
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }

    func makeContentView() -> UIView {
        let view = UIView()
        let labelStackView = makeStackView()
        [imageView, labelStackView].forEach(view.addSubview)

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(300)
        }

        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        return view
    }

    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
                return imageView
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [idLabel, heightLabel, weightLabel, typeLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
}
