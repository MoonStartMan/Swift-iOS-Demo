//
//  ViewController.swift
//  StackView-Demo
//
//  Created by 王潇 on 2023/6/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var coverStackView: UIStackView = UIStackView()
    
    private var topStackView: TopStackView = TopStackView()
    
    private var bottomStackView: BottomStackView = BottomStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        self.view.addSubview(coverStackView)
        coverStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        coverStackView.backgroundColor = .systemPink
        
        coverStackView.translatesAutoresizingMaskIntoConstraints = false
        coverStackView.distribution = .fill
        coverStackView.alignment = .fill
        coverStackView.axis = .vertical
        coverStackView.addArrangedSubview(topStackView)
        coverStackView.addArrangedSubview(bottomStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.distribution = .fill
        topStackView.alignment = .center
        topStackView.axis = .horizontal
        topStackView.spacing = 10
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.alignment = .center
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 20
    }
}

