//
//  ImageAlertViewController.swift
//  AlertViewController-Demo
//
//  Created by 王潇 on 2023/5/4.
//

import UIKit
import SnapKit

class ImageAlertViewController: UIAlertController {
    
    var imageName: String? {
        didSet {
            if let imageName = imageName {
                resetImageView(imageName: imageName)
            }
        }
    }
    
    private func resetImageView(imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.width.height.equalTo(50)
        }
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
    }
    
    func setLabelStyle(controller: UIAlertController, title: String, message: String) {
        let titleControllerStr = NSMutableAttributedString(string: title)
        titleControllerStr.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: title.count))
        titleControllerStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: NSRange(location: 0, length: title.count))
        controller.setValue(titleControllerStr, forKey: "attributedTitle")
        
        let messageControllerStr = NSMutableAttributedString(string: message)
        messageControllerStr.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 0, length: message.count))
        messageControllerStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .semibold), range: NSRange(location: 0, length: message.count))
        controller.setValue(messageControllerStr, forKey: "attributedMessage")
    }
    
    func setActionColor(action: UIAlertAction, color: UIColor) {
        action.setValue(color, forKey: "titleTextColor")
    }
    
    func setActionImage(action: UIAlertAction, imageName: String) {
        let iconImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        action.setValue(iconImage, forKey: "image")
    }
}
