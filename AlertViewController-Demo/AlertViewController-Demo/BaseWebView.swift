//
//  BaseWebView.swift
//  AlertViewController-Demo
//
//  Created by 王潇 on 2023/5/8.
//

import UIKit
import WebKit

class BaseWebView: WKWebView {

    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
