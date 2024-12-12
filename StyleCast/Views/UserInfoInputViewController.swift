import UIKit

class UserInfoInputViewController: UIViewController {

    private let appIconView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ユーザー名"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "年齢"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let maleButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let femaleButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登録", for: .normal)
        button.backgroundColor = .darkGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var selectedGender: Gender?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        view.addSubview(appIconView)
        view.addSubview(usernameTextField)
        view.addSubview(ageTextField)
        view.addSubview(maleButton)
        view.addSubview(femaleButton)
        view.addSubview(registerButton)

        NSLayoutConstraint.activate([
            // AppIcon
            appIconView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40
            ),
            appIconView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            appIconView.widthAnchor.constraint(equalToConstant: 144),
            appIconView.heightAnchor.constraint(equalToConstant: 144),

            // UsernameTextField
            usernameTextField.topAnchor.constraint(
                equalTo: appIconView.bottomAnchor, constant: 64
            ),
            usernameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 40
            ),
            usernameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -40
            ),
            usernameTextField.heightAnchor.constraint(equalToConstant: 48),

            // AgeTextField
            ageTextField.topAnchor.constraint(
                equalTo: usernameTextField.bottomAnchor, constant: 16
            ),
            ageTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 40
            ),
            ageTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -40
            ),
            ageTextField.heightAnchor.constraint(equalToConstant: 48),

            // GenderButtons
            maleButton.topAnchor.constraint(
                equalTo: ageTextField.bottomAnchor, constant: 30
            ),
            maleButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 40
            ),
            maleButton.heightAnchor.constraint(equalToConstant: 80),

            femaleButton.topAnchor.constraint(
                equalTo: ageTextField.bottomAnchor, constant: 32
            ),
            femaleButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -40
            ),
            femaleButton.heightAnchor.constraint(equalToConstant: 80),

            maleButton.trailingAnchor.constraint(
                equalTo: femaleButton.leadingAnchor, constant: -16
            ),
            maleButton.widthAnchor.constraint(equalTo: femaleButton.widthAnchor),

            // RegisterButton
            registerButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16
            ),
            registerButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 40
            ),
            registerButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -40
            ),
            registerButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupActions() {
        maleButton.addTarget(self, action: #selector(selectMale), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(selectFemale), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }

    @objc private func selectMale() {
        selectedGender = .male
        maleButton.layer.borderColor = UIColor.systemBlue.cgColor
        femaleButton.layer.borderColor = UIColor.clear.cgColor
    }

    @objc private func selectFemale() {
        selectedGender = .female
        maleButton.layer.borderColor = UIColor.clear.cgColor
        femaleButton.layer.borderColor = UIColor.systemRed.cgColor
    }

    @objc private func register() {
        let username = usernameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let gender = selectedGender

        print("ユーザー名: \(username)")
        print("年齢: \(age)")
        print("性別: \(gender?.value ?? "未選択")")
    }
}

#Preview {
    UserInfoInputViewController()
}
