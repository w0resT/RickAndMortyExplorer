import UIKit

final class CharacterDetailsNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    // MARK: - UINavigationControllerDelegate Methods
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> (any UIViewControllerAnimatedTransitioning)? {
        switch operation {
        case .none:
            return nil
        case .push:
            return CharacterDetailsPushAnimator()
        case .pop:
            return CharacterDetailsPopAnimator()
        @unknown default:
            fatalError("Случай не определен!")
        }
    }
}
