//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/10.
//

import Foundation

protocol NewsListProtocol: AnyObject {
    
}

final class NewsListPresenter {
    private weak var viewController: NewsListProtocol?
    
    init(viewController: NewsListProtocol) {
        self.viewController = viewController
    }
}
