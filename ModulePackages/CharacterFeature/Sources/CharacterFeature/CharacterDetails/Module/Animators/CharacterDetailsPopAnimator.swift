import UIKit

internal final class CharacterDetailsPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from)
        else { return }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(
            toViewController.view,
            belowSubview: fromViewController.view
        )
        
        fromViewController.view.alpha = 1.0
        
        UIView.animate(withDuration: animationDuration) {
            fromViewController.view.alpha = 0.0
        } completion: { _ in
            fromViewController.view.alpha = 1.0
            if transitionContext.transitionWasCancelled {
                toViewController.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
