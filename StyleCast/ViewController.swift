import UIKit

class ViewController: UIViewController {
    
    let requester = OpenAPIRequester()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your question"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ask", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc private func buttonTapped() {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        Task {
            do {
                let response = try await requester.postGPT(text)
                resultLabel.text = response
            } catch {
                let error = error as? APIClientError ?? APIClientError.unknown
                resultLabel.text = error.title
            }
        }
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

#Preview {
    ViewController()
}
