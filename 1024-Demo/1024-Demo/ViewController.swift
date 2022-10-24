//
//  ViewController.swift
//  1024-Demo
//
//  Created by 王潇 on 2022/10/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var titleLabel: UILabel = UILabel()
    
    var textLabel: UILabel = UILabel()
    
    var heartView: HeartView = HeartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(-300)
        }
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = "祝所有程序员宝宝们"
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.titleLabel.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(200)
                make.centerX.equalToSuperview()
            }
            self.titleLabel.layoutIfNeeded()
        }
        
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(-300)
        }
        textLabel.font = .systemFont(ofSize: 36, weight: .bold)
        textLabel.textColor = .white
        textLabel.text = "1024 节日快乐"
        
        view.addSubview(self.heartView)
        heartView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        heartView.isHidden = true
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.textLabel.snp.remakeConstraints { make in
                make.top.equalTo(self.titleLabel.snp.bottom).offset(100)
                make.centerX.equalToSuperview()
            }
            self.textLabel.layoutIfNeeded()
        } completion: { isFinsh in
            if isFinsh {
                UIView.animate(withDuration: 1) {
                    self.heartView.isHidden = false
                    self.heartView.snp.remakeConstraints { make in
                        make.bottom.equalToSuperview().offset(-150)
                        make.centerX.equalToSuperview()
                    }
                    self.heartView.layoutIfNeeded()
                }
            }
        }
    }

}

