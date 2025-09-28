import UIKit

final class FooterLoadingCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Type Properties
    
    static let reuseIdentifier = "FooterLoadingCollectionReusableView"
    
    // MARK: - UI Elements
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func startAnimating() {
        loadingIndicator.startAnimating()
    }
    
    func stopAnimation() {
        loadingIndicator.stopAnimating()
    }
}

// MARK: - Setup UI

private extension FooterLoadingCollectionReusableView {
    func setupUI() {
        setupLoadingIndicator()
    }
    
    func setupLoadingIndicator() {
        if loadingIndicator.superview == nil {
            addSubview(loadingIndicator)
        }
        
        NSLayoutConstraint.activate([
            loadingIndicator.heightAnchor.constraint(equalToConstant: 100),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 100),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
