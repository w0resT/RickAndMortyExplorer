import UIKit

protocol CharactersCollectionViewDelegateProtocol: AnyObject {
    func didCreateFooterView(_ footer: FooterLoadingCollectionReusableView)
}
