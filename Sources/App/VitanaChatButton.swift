import UIKit
@_spi(RiveExperimental) import RiveRuntime

final class VitanaChatButton: UIView {
    static let smallHeight: CGFloat = 35
    static let largeHeight: CGFloat = 48
    static let smallWidth: CGFloat = 113
    static let largeWidth: CGFloat = 188
    
    private let isSmall: Bool
    private let backgroundRiveName: String
    private let iconRiveName: String?
    
    private var backgroundRive: RiveViewModel?
    private var iconRive: RiveViewModel?
    
    private weak var backgroundRiveView: UIView?
    private weak var iconRiveView: UIView?
    
    private let titleLabel = UILabel()
    private var didSetupRiveViews = false
    
    init(
        isSmall: Bool,
        backgroundRiveName: String = "output-vitana-bt-bg",
        iconRiveName: String? = "output-vitana-icon"
    ) {
        self.isSmall = isSmall
        self.backgroundRiveName = backgroundRiveName
        self.iconRiveName = iconRiveName
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        pause()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window == nil {
            pause()
            return
        }

        guard !didSetupRiveViews else { return }
        didSetupRiveViews = true

        // Delay heavy Rive setup to avoid blocking first frame on launch.
        DispatchQueue.main.async { [weak self] in
            self?.setupRiveViewsIfPossible()
        }
    }
    
    func play() {
        backgroundRive?.play()
        iconRive?.play()
    }
    
    func pause() {
        backgroundRive?.pause()
        iconRive?.pause()
    }
    
    private func setupUI() {
        let height = isSmall ? Self.smallHeight : Self.largeHeight
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        backgroundColor = .black
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = isSmall ? "Vitana" : "Ask Vitana"
        titleLabel.font = isSmall ? .systemFont(ofSize: 13, weight: .medium) : .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: isSmall ? 38 : 44),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupRiveViewsIfPossible() {
        if Bundle.main.url(forResource: backgroundRiveName, withExtension: "riv") != nil {
            let model = RiveViewModel(fileName: backgroundRiveName, autoPlay: false)
            let riveView = model.createRiveView()
            riveView.translatesAutoresizingMaskIntoConstraints = false
            insertSubview(riveView, at: 0)
            NSLayoutConstraint.activate([
                riveView.leadingAnchor.constraint(equalTo: leadingAnchor),
                riveView.trailingAnchor.constraint(equalTo: trailingAnchor),
                riveView.topAnchor.constraint(equalTo: topAnchor),
                riveView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
            backgroundRive = model
            backgroundRiveView = riveView
        } else {
            titleLabel.text = "\(titleLabel.text ?? "") (missing bg riv)"
        }
        
        guard let iconRiveName,
              Bundle.main.url(forResource: iconRiveName, withExtension: "riv") != nil else {
            return
        }
        
        let iconModel = RiveViewModel(fileName: iconRiveName, autoPlay: false)
        let iconView = iconModel.createRiveView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        let iconSize: CGFloat = isSmall ? 20 : 24
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: iconSize),
            iconView.heightAnchor.constraint(equalToConstant: iconSize),
        ])
        iconRive = iconModel
        iconRiveView = iconView
    }
}
