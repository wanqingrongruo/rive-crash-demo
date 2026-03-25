import UIKit

final class DemoViewController: UIViewController {
    private let infoLabel = UILabel()
    private let smallButton = VitanaChatButton(isSmall: true)
    private let largeButton = VitanaChatButton(isSmall: false)
    
    private let playBothBtn = UIButton(type: .system)
    private let pauseAllBtn = UIButton(type: .system)
    private let toggleLargeBtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "VitanaChatButton Demo"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    private func setupUI() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.numberOfLines = 0
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textColor = .secondaryLabel
        infoLabel.text = """
        The app crashes the first time it runs when clicking "play both", but it works fine on subsequent runs. Uninstalling the app, cleaning the Xcode build, and performing the same operation again will cause the crash to reappear.
        After launching the app, if you disconnect from Xcode and perform the operation, it will definitely crash.
        """
        
        [playBothBtn, pauseAllBtn, toggleLargeBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentHorizontalAlignment = .left
        }
        
        playBothBtn.setTitle("Play Both", for: .normal)
        pauseAllBtn.setTitle("Pause All", for: .normal)
        toggleLargeBtn.setTitle("Toggle Large Visible", for: .normal)
        
        playBothBtn.addTarget(self, action: #selector(playBoth), for: .touchUpInside)
        pauseAllBtn.addTarget(self, action: #selector(pauseAll), for: .touchUpInside)
        toggleLargeBtn.addTarget(self, action: #selector(toggleLarge), for: .touchUpInside)
        
        smallButton.translatesAutoresizingMaskIntoConstraints = false
        largeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        view.addSubview(playBothBtn)
        view.addSubview(pauseAllBtn)
        view.addSubview(toggleLargeBtn)
        view.addSubview(smallButton)
        view.addSubview(largeButton)
        
        largeButton.isHidden = true
        
        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: g.topAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -16),
            
            playBothBtn.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            playBothBtn.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
            playBothBtn.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            
            pauseAllBtn.topAnchor.constraint(equalTo: playBothBtn.bottomAnchor, constant: 8),
            pauseAllBtn.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
            pauseAllBtn.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            
            toggleLargeBtn.topAnchor.constraint(equalTo: pauseAllBtn.bottomAnchor, constant: 8),
            toggleLargeBtn.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
            toggleLargeBtn.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            
            smallButton.topAnchor.constraint(equalTo: toggleLargeBtn.bottomAnchor, constant: 24),
            smallButton.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
            smallButton.widthAnchor.constraint(equalToConstant: VitanaChatButton.smallWidth),
            smallButton.heightAnchor.constraint(equalToConstant: VitanaChatButton.smallHeight),
            
            largeButton.topAnchor.constraint(equalTo: smallButton.bottomAnchor, constant: 20),
            largeButton.leadingAnchor.constraint(equalTo: infoLabel.leadingAnchor),
            largeButton.widthAnchor.constraint(equalToConstant: VitanaChatButton.largeWidth),
            largeButton.heightAnchor.constraint(equalToConstant: VitanaChatButton.largeHeight),
        ])
    }
    
    @objc private func playBoth() {
        smallButton.play()
        if !largeButton.isHidden { largeButton.play() }
    }
    
    @objc private func pauseAll() {
        smallButton.pause()
        largeButton.pause()
    }
    
    @objc private func toggleLarge() {
        largeButton.isHidden.toggle()
        if largeButton.isHidden {
            largeButton.pause()
        }
    }
}
