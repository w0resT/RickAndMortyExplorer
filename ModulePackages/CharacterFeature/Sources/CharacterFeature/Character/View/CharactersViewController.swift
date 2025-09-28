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
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search characters"
        return search
    }()
    
    private var footerLoadingIndicator: FooterLoadingCollectionReusableView?
    
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
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
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
            loadingIndicator.heightAnchor.constraint(equalToConstant: 100),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 100),
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
        viewModel.charactersChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] change in
                switch change {
                case .reload:
                    self?.collectionView.reloadData()
                    self?.collectionView.setContentOffset(.zero, animated: true)
                case .append(let indexPaths):
                    self?.collectionView.insertItems(at: indexPaths)
                }
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
        print("Loading state: \(state.rawValue)")
        switch state {
        case .none:
            break
        case .loading:
            loadingIndicator.startAnimating()
        case .loadingNext:
            break
        case .success:
            loadingIndicator.stopAnimating()
        case .error:
            loadingIndicator.stopAnimating()
            footerLoadingIndicator?.stopAnimation()
        case .cancelled:
            break
        }
    }
    
    @objc func didTapFilters() {
        viewModel.didTapFilters()
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
        
        let avatarImage = self.viewModel.imageLoads
            .filter { $0.id == character.id }
            .map { UIImage(data: $0.data) }
            .eraseToAnyPublisher()
        
        cell.bindAvatarImage(avatarImage)
        self.viewModel.loadImage(for: character)
        
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
        
        self.footerLoadingIndicator = footer
                
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        guard let footerView = view as? FooterLoadingCollectionReusableView else {
            return
        }
        
        if viewModel.isLastPageReached {
            footerView.stopAnimation()
        } else {
            footerView.startAnimating()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath
    ) {
        guard let footerView = view as? FooterLoadingCollectionReusableView else {
            return
        }
        
        footerView.stopAnimation()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard !viewModel.isLastPageReached else { return .zero }
        
        return CGSize(
            width: collectionView.bounds.width,
            height: 100
        )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.loadingState != .loading,
              viewModel.loadingState != .loadingNext,
              !viewModel.isLastPageReached,
              !viewModel.characters.isEmpty
        else { return }
        
        let scrollViewOffset = scrollView.contentOffset.y
        let contentViewHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.bounds.height
        
        if scrollViewOffset >= (contentViewHeight - scrollViewHeight) {
            viewModel.loadMoreCharacters()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let inset: CGFloat = 15
        let width = collectionView.frame.width - inset * 2
        return CGSize(width: width, height: 108)
    }
}

// MARK: -

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchQuery = searchController.searchBar.text ?? ""
    }
}
