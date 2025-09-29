import UIKit
import Combine

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Type Properties
    
    static let reuseIdentifier = "CharacterCollectionViewCell"
    
    // MARK: - Properties
    
    private var cancellable: AnyCancellable?
    
    // MARK: - UI Elements
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusSpeciesGenderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Last known location:"
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.heightAnchor.constraint(equalToConstant: 8).isActive = true
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    override func prepareForReuse() {
        self.avatarImageView.image = nil
        self.nameLabel.text = nil
        self.statusSpeciesGenderLabel.text = nil
        self.locationNameLabel.text = nil
        self.statusIndicatorView.backgroundColor = .systemBackground
        self.contentView.backgroundColor = .systemBackground
        
        self.cancellable?.cancel()
    }
    
    func configure(
        with viewModel: CharacterCollectionViewCellViewModel,
        gender: CharacterGender,
        status: CharacterStatus
    ) {
        avatarImageView.image = nil
        nameLabel.text = viewModel.name
        statusSpeciesGenderLabel.text = viewModel.statusSpeciesGender
        locationNameLabel.text = viewModel.locationName
        statusIndicatorView.backgroundColor = getStatusColor(by: status)
        contentView.backgroundColor = getBackgroundColor(by: gender)
    }
    
    func bindAvatarImage(_ avatarImage: AnyPublisher<UIImage?, Never>) {
        cancellable = avatarImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.avatarImageView.image = image
            }
    }
}

// MARK: - Setup UI

private extension CharacterCollectionViewCell {
    func setupUI() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        setupAvatarImageView()
        setupNameLabel()
        setupStatusStackView()
        setupLocationNameLabel()
        setupLocationTitleLabel()
    }
    
    func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func setupStatusStackView() {
        contentView.addSubview(statusStackView)
        
        statusStackView.addArrangedSubview(statusIndicatorView)
        statusStackView.addArrangedSubview(statusSpeciesGenderLabel)
        
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            statusStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            statusStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func setupLocationNameLabel() {
        contentView.addSubview(locationNameLabel)
        
        NSLayoutConstraint.activate([
            locationNameLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -6),
            locationNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            locationNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func setupLocationTitleLabel() {
        contentView.addSubview(locationTitleLabel)
        
        NSLayoutConstraint.activate([
            locationTitleLabel.bottomAnchor.constraint(equalTo: locationNameLabel.topAnchor, constant: -2),
            locationTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            locationTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
}

// MARK: - Helpers

private extension CharacterCollectionViewCell {
    func getBackgroundColor(by gender: CharacterGender) -> UIColor {
        return switch gender {
        case .male:
            UIColor.systemBlue.withAlphaComponent(0.3)
        case .female:
            UIColor.systemPink.withAlphaComponent(0.3)
        case .genderless:
            UIColor.systemYellow.withAlphaComponent(0.3)
        case .unknown:
            UIColor.systemGray.withAlphaComponent(0.3)
        }
    }
    
    func getStatusColor(by status: CharacterStatus) -> UIColor {
        return switch status {
        case .alive:
            .systemGreen
        case .dead:
            .systemRed
        case .unknown:
            .systemGray
        }
    }
}
