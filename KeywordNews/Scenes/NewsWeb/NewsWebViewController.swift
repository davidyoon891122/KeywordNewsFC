//
//  NewsWebViewController.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/12.
//

import Foundation
import UIKit
import WebKit

final class NewsWebViewController: UIViewController {
    private let rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    private let webView: WKWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupWebView()
    }
    
}

private extension NewsWebViewController {
    func setupNavigationBar() {
        navigationItem.title = "기사 제목"
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: "https://m.naver.com") else {
            navigationController?.popViewController(animated: true)
            return
        }
        view = webView
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = "뉴스 링크"
    }
}
