//
//  InfoViewController.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 5/3/25.
//


import UIKit

import SnapKit
import Then

final class InfoViewController: UIViewController {

    // MARK: - Properties

    private var keyword: String = ""
    private let userId: Int = 1 // 실제 로그인된 사용자 ID로 교체 필요

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setLayout()
    }

    // MARK: - Actions

    
    @objc private func searchButtonTap() {
        Task {
            do {
                let nicknameList = try await GetInfoService.shared.fetchNicknameList(keyword: self.keyword.isEmpty ?  nil : self.keyword, userId: self.userId)
                
                let nicknameTexts = nicknameList.map { "\($0)" }.joined(separator: "\n")
                self.infoLabel.text = "닉네임 리스트:\n\(nicknameTexts)"
            } catch {
                self.infoLabel.text = "조회 실패 :\(error.localizedDescription)"
            }
        }
    }

    
    @objc private func textFieldDidEditing(_ textField: UITextField) {
        self.keyword = textField.text ?? ""
    }

    // MARK: - Layout

    private func setLayout() {
        self.view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(200)
        }

        [keywordTextField, infoLabel, searchButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }

    // MARK: - UI Components

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 20
    }

    private lazy var keywordTextField = UITextField().then {
        $0.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .editingChanged)
        $0.backgroundColor = .lightGray
        $0.placeholder = "검색할 닉네임 키워드를 입력하세요"
        $0.layer.cornerRadius = 8
        $0.setLeftPadding(12)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private lazy var searchButton = UIButton().then {
        $0.addTarget(self,
                     action: #selector(searchButtonTap),
                     for: .touchUpInside)
        $0.backgroundColor = .blue
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private lazy var infoLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 16)
    }
}

// MARK: - Padding Extension

private extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
