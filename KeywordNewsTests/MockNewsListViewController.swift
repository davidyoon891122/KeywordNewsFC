//
//  MockNewsListViewController.swift
//  KeywordNewsTests
//
//  Created by David Yoon on 2022/03/13.
//

import Foundation
@testable import KeywordNews

final class MockNewsListViewController: NewsListProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledEndRefreshing = false
    var isCalledMoveToNewsWebViewController = false
    var isCalledReloadTableView = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func endRefreshing() {
        isCalledEndRefreshing = true
    }
    
    func moveToNewsWebViewController(with news: News) {
        isCalledMoveToNewsWebViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
}
