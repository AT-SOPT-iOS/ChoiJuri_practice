//
//  WelcomeViewController.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 4/5/25.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    var id: String? = ""
    
    private let imageView: UIImageView  = {
        let image = UIImage(resource: .profile)
        let imageView = UIImageView(frame: CGRect(x: 112, y: 87, width: 150, height: 150))
        imageView.image = image
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 140, y: 295, width: 95, height: 60))
        label.text = "???님\n반가워요!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .head1
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 35, y: 422, width: 332, height: 58))
        button.backgroundColor = .accent
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .subhead1
        button.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var reLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 35, y: 498, width: 332, height: 58))
        button.backgroundColor = .gray200
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(.gray400, for: .normal)
        button.titleLabel?.font = .subhead1
        button.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setLayout()
        
        bindID()
    }
    
    private func setLayout() {
        [imageView, nameLabel, backButton, reLoginButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    @objc
    private func backButtonDidTapped() {
        if self.navigationController == nil {   // 모달
            self.dismiss(animated: true)
        } else {    // 스택
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func bindID() {
        guard let text = id else { return }
        self.nameLabel.text = "\(text)님 \n반가워요!"
    }
    
    func setLabelText(id: String?) {
        self.id = id
    }
}

#Preview(traits: .portrait, body: {
    WelcomeViewController()
})
