//
//  WebViewController.swift
//  WebView-Demo
//
//  Created by 王潇 on 2021/12/19.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    /// zkWebView
    lazy var wkWebView = WKWebView()
    /// 进度条
    lazy var progressView = UIProgressView()
    /// 顶部菜单栏
    private var topBarView: WebViewTopBar!
    
    /// 是否需要覆盖底部安全区铺满
    var isCover: Bool = false {
        didSet {
            if isCover {
                wkWebView.snp.remakeConstraints { make in
                    make.top.equalTo(topBarView.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview().offset(kSafeAreaBottom)
                }
            } else {
                wkWebView.snp.remakeConstraints { make in
                    make.top.equalTo(topBarView.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }
        }
    }
    
    /// 标题
    var titleText: String? {
        didSet {
            if let title = titleText {
                topBarView.titleString = title
            }
        }
    }
    
    /// 路径
    var urlString: String? {
        didSet {
            if let address = urlString {
                if let url = URL(string: address) {
                    let request = URLRequest(url: url)
                    wkWebView.load(request)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topBarView = WebViewTopBar()
        self.view.addSubview(topBarView)
        topBarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(kSafeAreaTop + 6)
            make.left.right.equalToSuperview()
            make.height.equalTo(64)
        }
        topBarView.leftClickBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        wkWebView = WKWebView()
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(kSafeAreaBottom)
        }
        wkWebView.navigationDelegate = self
    }
    
    //  隐藏导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension WebViewController {
    //  监听网页加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.progressView.progress = Float(self.wkWebView.estimatedProgress)
    }
    
    //  页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("开始加载")
    }
    
    //  当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("当内容开始返回...")
    }
    
    //  页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("页面加载完成之后调用")
//        self.title = self.wkWebView.title
//        UIView.animate(withDuration: 0.5) {
//            self.progressView.isHidden = true
//        }
    }
    
    //  页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
    }
}
