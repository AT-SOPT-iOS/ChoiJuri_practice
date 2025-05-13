//
//  ViewController.swift
//  ATSOPT_practice
//
//  Created by 최주리 on 4/5/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var testView: UIView = UIView(
        frame: .init(origin: .init(x: 0, y: 0),
        size: .init(width: 410,height: 100)
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(testView)
    }

    
}

#Preview(traits: .defaultLayout, body: {
    ViewController()
})


