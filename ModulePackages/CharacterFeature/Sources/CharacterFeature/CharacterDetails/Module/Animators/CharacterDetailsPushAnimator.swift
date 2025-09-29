import UIKit

internal final class CharacterDetailsPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Properties
    
    private let animationDuration: TimeInterval
    
    // MARK: - Initialization
    
    internal init(animationDuration: TimeInterval = 0.25) {
        self.animationDuration = animationDuration
    }
    
    // MARK: - UIViewControllerTransitioningDelegate Methods
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        toViewController.view.alpha = 0.0
        
        UIView.animate(withDuration: animationDuration) {
            toViewController.view.alpha = 1.0
        } completion: { _ in
            if transitionContext.transitionWasCancelled {
                toViewController.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
