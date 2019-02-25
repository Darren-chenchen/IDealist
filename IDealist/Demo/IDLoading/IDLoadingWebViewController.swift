//
//  IDLoadingWebViewController.swift
//  IdealDemo
//
//  Created by darren on 2018/11/23.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit

class IDLoadingWebViewController: IDBaseViewController, UIWebViewDelegate {

    lazy var webview: UIWebView = {
        let web = UIWebView.init(frame: CGRect.init(x: 0, y: KNavgationBarHeight, width: KScreenWidth, height: KScreenHeight-KNavgationBarHeight))
        web.loadRequest(URLRequest.init(url: URL.init(string: "https://www.darrenblog.cn/")!))
        web.delegate = self
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "网页展示"
        self.view.addSubview(self.webview)
        
        IDLoading.id_showProgressLine(onView: self.id_customNavBar)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        IDLoading.id_dismissNav()
    }
}
