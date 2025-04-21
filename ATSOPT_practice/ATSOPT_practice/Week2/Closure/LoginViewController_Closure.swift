//
//  LoginViewController_Closure.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 4/12/25.
//

import UIKit

final class LoginViewController_Closure: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 75, y: 161, width: 250, height: 44))
        label.text = "동네라서 가능한 모든 것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .subhead1
        return label
    }()
    
    
    private let idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 35, y: 276, width: 335, height: 52))
        textField.placeholder = "     아이디"
        textField.font = .info12
        textField.backgroundColor = .gray200
        return textField
    }()
        
    private let passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 35, y: 335, width: 335, height: 52))
        textField.placeholder = "     비밀번호"
        textField.font = .info12
        textField.isSecureTextEntry = true
        textField.backgroundColor = .gray200
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 35, y: 422, width: 332, height: 58))
        button.backgroundColor = .accent
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .subhead1
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setLayout()
    }
    
    private func setLayout() {
        [titleLabel, idTextField, passwordTextField, loginButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    @objc
    private func loginButtonDidTapped() {
        pushToWelcomeVC()
    }
    
    private func presentToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Closure()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.setLabelText(id: idTextField.text)
        self.present(welcomeViewController, animated: true)
    }

    private func pushToWelcomeVC() {
        let welcomeViewController = WelcomeViewController_Closure()
//        welcomeViewController.navigationItem.hidesBackButton = true
//        welcomeViewController.setLabelText(id: idTextField.text)
        
        welcomeViewController.id = passwordTextField.text
        welcomeViewController.loginDataCompletion = { [weak self] data in
            print("클로저 id: \(data)")
            guard let self else { return }
            
            self.passwordTextField.text = data
        }
        
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

#Preview(traits: .portrait, body: {
    let navigationController = UINavigationController(rootViewController: LoginViewController_Closure())
    navigationController
})

