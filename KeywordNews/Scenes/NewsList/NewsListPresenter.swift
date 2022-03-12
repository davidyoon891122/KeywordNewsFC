//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/10.
//

import Foundation
import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigationBar()
    func setupViews()
    func endRefreshing()
    func moveToNewsWebViewController(with news: News)
    func reloadTableView()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol
    
    private var newsList: [News] = []
    private let tags: [String] = [
        "IT", "아이폰", "개발", "개발자", "판교", "게임",
        "앱개발", "강남", "스타트업"
    ]
    
    private var currentKeyword = ""
    // 지금까지 request 된, 가지고 있는 보여주고 있는 page가 어디인지 알고 있어야 한다
    private var currentPage: Int = 0
    // 한 페이지에 최대 몇 개까지 보여줄건지
    private let display: Int = 20
    // 0 : 0 * 20 + 1, 1: 1 * 20 + 1
    
    init(
        viewController: NewsListProtocol,
        newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    ) {
        self.viewController = viewController
        self.newsSearchManager = newsSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupViews()
    }
    
    func didPulledRefreshControl() {
        requestNewsList(isNeededToReset: true)
    }
    
}

extension NewsListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        viewController?.moveToNewsWebViewController(with: news)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        // current page 0 이고 current Row 17 이상이면 request 요청 , current page 0 인데  r
        guard (currentRow % 20) == display - 3 && (currentRow / display) == (currentPage - 1) else {
            return
        }
        requestNewsList(isNeededToReset: false)
    }
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListTableViewCell.identifier,
            for: indexPath
        ) as? NewsListTableViewCell
        let news = newsList[indexPath.row]
        cell?.setup(news: news)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: NewsListTableViewHeaderView.identifier
        ) as? NewsListTableViewHeaderView
        
        header?.setup(tags: tags, delegate: self)
        return header
    }
}

extension NewsListPresenter: NewsListTableViewHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        currentKeyword = tags[selectedIndex]
        requestNewsList(isNeededToReset: true)
    }
}

private extension NewsListPresenter {
    func requestNewsList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            newsList = []
        }
        
        newsSearchManager.request(
            from: currentKeyword,
            start: (currentPage * display) + 1,
            display: display
        ) { [weak self] newsArray in
            // 2번째 페이지의 값을 리퀘스트 한 경우
            self?.newsList += newsArray
            self?.currentPage += 1
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefreshing()
        }
    }
}
