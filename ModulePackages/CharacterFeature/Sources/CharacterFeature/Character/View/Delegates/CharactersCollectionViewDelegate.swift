import UIKit

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

final class CharactersCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    private let viewModel: CharactersViewModel
    weak var output: CharactersCollectionViewDelegateProtocol?
    
    // MARK: - Initialization
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Methods
    
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
        
        let avatarImage = self.viewModel.didImageLoad
            .compactMap { event -> (id: Int, data: Data)? in
                guard case let .loaded(id, data) = event else { return nil }
                return (id, data)
            }
            .filter { $0.id == character.id }
            .map { UIImage(data: $0.data) }
            .eraseToAnyPublisher()
        
        cell.bindAvatarImage(avatarImage)
        self.viewModel.handle(.loadImage(character))
        
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
        viewModel.handle(.selectCharacter(character))
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
        
        output?.didCreateFooterView(footer)
                
        return footer
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
            viewModel.handle(.loadMoreCharacters)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CharactersCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
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
