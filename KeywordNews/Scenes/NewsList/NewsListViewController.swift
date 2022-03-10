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
}

extension NewsListViewController: NewsListProtocol {
    
}
