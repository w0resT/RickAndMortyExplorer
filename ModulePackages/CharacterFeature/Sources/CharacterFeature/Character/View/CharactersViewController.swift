import UIKit
import Combine
import ApplicationCore

final class CharactersViewController: UIViewController {
    
    // MARK: - Properties
    
    private var navigationOutput: NavigationListenerProtocol?
    
    private let viewModel: CharactersViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            FooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterLoadingCollectionReusableView.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initialization
    
    init(
        navigationOutput: NavigationListenerProtocol?,
        viewModel: CharactersViewModel
    ) {
        self.navigationOutput = navigationOutput
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        
        loadingIndicator.startAnimating()
    }
}

// MARK: - Setup UI

private extension CharactersViewController {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Characters"
        
        addFiltersButton()
        setupCollectionView()
        setupLoadingIndicator()
    }
    
    func addFiltersButton() {
        let barButton = UIBarButtonItem(
            title: "Filters",
            image: nil,
            target: self,
            action: #selector(didTapFilters))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func setupCollectionView() {
        if collectionView.superview == nil {
            view.addSubview(collectionView)
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupLoadingIndicator() {
        if loadingIndicator.superview == nil {
            view.addSubview(loadingIndicator)
        }
        
        NSLayoutConstraint.activate([
            loadingIndicator.heightAnchor.constraint(equalToConstant: 70),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 70),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Binding

private extension CharactersViewController {
    func setupBinding() {
        setupCharactersBinding()
        setupLoadingStateBinding()
    }
    
    func setupCharactersBinding() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func setupLoadingStateBinding() {
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleLoadingState(state)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Helpers

private extension CharactersViewController {
    func handleLoadingState(_ state: CharactersLoadingState) {
        switch state {
        case .loading:
            print("loading state")
        case .success:
            print("success state")
            loadingIndicator.stopAnimating()
        case .error:
            print("error state")
            loadingIndicator.stopAnimating()
        }
    }
    
    @objc func didTapFilters() {
        print("didTapFilters")
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let character = viewModel.characters[indexPath.item]
        let viewModel = CharacterCollectionViewCellViewModel(character: character)
        
        cell.configure(
            with: viewModel,
            gender: character.gender,
            status: character.status
        )
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.1) {
            cell?.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                cell?.alpha = 1
            }
        }
        
        let character = viewModel.characters[indexPath.item]
        viewModel.didSelectCharacter(character)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionFooter
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoadingCollectionReusableView.reuseIdentifier,
            for: indexPath
        ) as? FooterLoadingCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard viewModel.needToShowNextLoadingIndicator() else { return .zero }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 70
        )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let inset: CGFloat = 12
        let width = collectionView.frame.width - inset * 2
        return CGSize(width: width, height: 108)
    }
}
