//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/10.
//

import UIKit
import SnapKit

final class NewsListViewController: UIViewController {
    private lazy var presenter = NewsListPresenter(viewController: self)
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPulledRefreshControl), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.register(
            NewsListTableViewHeaderView.self,
            forHeaderFooterViewReuseIdentifier: NewsListTableViewHeaderView.identifier
        )
        tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupViews() {
        [tableView]
            .forEach {
                view.addSubview($0)
            }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moveToNewsWebViewController(with news: News) {
        let newsWebViewController = NewsWebViewController(news: news)
        navigationController?.pushViewController(newsWebViewController, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

private extension NewsListViewController {
    @objc func didPulledRefreshControl() {
        presenter.didPulledRefreshControl()
    }
}
