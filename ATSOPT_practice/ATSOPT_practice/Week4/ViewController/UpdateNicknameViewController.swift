//
//  UpdateNicknameViewController.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/9/25.
//

import UIKit

class UpdateNicknameViewController: UIViewController {
    private var nickname: String = ""
    private var userId: Int
    
    init(userId: Int) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }
    
    @objc private func updateNicknameButtonTap() {
            Task {
                do {
                    let success = try await UpdateNicknameService.shared.updateNickname(userID: self.userId, nickname: self.nickname)
                
                    let alert = UIAlertController(
                        title: "닉네임 변경 성공",
                        message: nil,
                        preferredStyle: .alert
                    )
                    
                    let okAction = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                } catch {
                    let alert = UIAlertController(
                        title: "닉네임 변경 실패",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    let okAction = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                    
                    print("닉네임 변경 에러:", error)
                }
            }
        }
    
    @objc private func textFieldDidEditing(_ textField: UITextField) {
        nickname = textField.text ?? ""
    }
    
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(200)
        }
        
        [nickNameTextField, updateNicknameButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 20
    }
    
    private lazy var nickNameTextField = UITextField().then {
        $0.addTarget(self,
                     action: #selector(textFieldDidEditing(_:)),
                     for: .allEvents)
        $0.backgroundColor = .lightGray
        $0.placeholder = "변경할 닉네임을 입력하슈"
    }
    
    private lazy var updateNicknameButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.setTitle("닉네임 변경", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.addTarget(self, action: #selector(updateNicknameButtonTap), for: .touchUpInside)
    }
}
