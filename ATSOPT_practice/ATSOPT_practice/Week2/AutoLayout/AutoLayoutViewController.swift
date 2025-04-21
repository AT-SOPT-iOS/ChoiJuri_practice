//
//  AutoLayoutViewController.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 4/12/25.
//

import UIKit

final class AutoLayoutViewController: UIViewController {

    private var yellowView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .yellow
        return view
    }()
    
    private var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        
        return view
    }()
    
    private var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setHierachy()
        setLayout()
    }
    
    private func setLayout() {
        let width = UIScreen.main.bounds.width / 2
        let height = UIScreen.main.bounds.height / 4
        
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: view.topAnchor),
            yellowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            yellowView.widthAnchor.constraint(equalToConstant: width),
            yellowView.heightAnchor.constraint(equalToConstant: height)
        ])
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: view.topAnchor, constant: height),
            greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greenView.widthAnchor.constraint(equalToConstant: width),
            greenView.heightAnchor.constraint(equalToConstant: height)
        ])
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: greenView.bottomAnchor),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.widthAnchor.constraint(equalToConstant: width),
            blackView.heightAnchor.constraint(equalToConstant: height)
        ])
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: blackView.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: width),
            blueView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setHierachy() {
        [yellowView, greenView, blackView, blueView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

#Preview(traits: .defaultLayout, body: {
    AutoLayoutViewController()
})
