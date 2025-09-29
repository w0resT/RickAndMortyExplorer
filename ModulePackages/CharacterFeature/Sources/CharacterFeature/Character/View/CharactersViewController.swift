import UIKit
import Combine
import ApplicationCore
import ApplicationResources

final class CharactersViewController: UIViewController {
    
    // MARK: - Properties
    
    private var navigationOutput: NavigationListenerProtocol?
    
    private let viewModel: CharactersViewModel
    private var cancellables = Set<AnyCancellable>()
    private var collectionViewDelegate: CharactersCollectionViewDelegate
    
    // MARK: - UI Elements
    
    private lazy var charactersView = CharactersView()
    
    // MARK: - Initialization
    
    init(
        navigationOutput: NavigationListenerProtocol?,
        viewModel: CharactersViewModel
    ) {
        self.navigationOutput = navigationOutput
        self.viewModel = viewModel
        
        self.collectionViewDelegate = CharactersCollectionViewDelegate(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = charactersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        setupBinding()
    }
}

// MARK: - Setup UI

private extension CharactersViewController {
    func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = charactersView.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.title = Localization.Characters.title
        
        addFiltersButton()
    }
    
    func setupDelegates() {
        charactersView.collectionView.dataSource = collectionViewDelegate
        charactersView.collectionView.delegate = collectionViewDelegate
        charactersView.searchController.searchResultsUpdater = self
        collectionViewDelegate.output = self
    }
    
    func setupBinding() {
        setupCharactersBinding()
        setupLoadingStateBinding()
    }
    
    func addFiltersButton() {
        let barButton = UIBarButtonItem(
            title: Localization.Characters.Button.filter,
            image: nil,
            target: self,
            action: #selector(didTapFilters)
        )
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func setupCharactersBinding() {
        viewModel.didCharactersChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] change in
                switch change {
                case .reload:
                    self?.charactersView.collectionView.reloadData()
                    self?.charactersView.collectionView.setContentOffset(.zero, animated: true)
                case .append(let indexPaths):
                    self?.charactersView.collectionView.insertItems(at: indexPaths)
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
        switch state {
        case .loading: charactersView.startLoading()
        case .loadingNext: charactersView.startLoadingNext()
        case .success, .error: charactersView.stopLoading()
        case .cancelled, .none: break
        }
    }
    
    @objc func didTapFilters() {
        viewModel.handle(.tapFilters)
    }
}

// MARK: - CharactersCollectionViewDelegateProtocol

extension CharactersViewController: CharactersCollectionViewDelegateProtocol {
    func didCreateFooterView(_ footer: FooterLoadingCollectionReusableView) {
        charactersView.footerLoadingIndicator = footer
    }
}

// MARK: - UISearchResultsUpdating

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchQuery = searchController.searchBar.text ?? ""
    }
}
