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
    private let news: News
    
    private let rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    private let webView: WKWebView = WKWebView()
    
    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupWebView()
    }
    
}

private extension NewsWebViewController {
    func setupNavigationBar() {
        navigationItem.title = news.title.htmlToString
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: news.link) else {
            navigationController?.popViewController(animated: true)
            return
        }
        view = webView
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = news.link
    }
}
