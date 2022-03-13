//
//  NewsListPresenterTest.swift
//  KeywordNewsTests
//
//  Created by David Yoon on 2022/03/13.
//

import Foundation
import XCTest

@testable import KeywordNews

class NewsListPresenterTest: XCTestCase {
    var sut: NewsListPresenter!
    var viewController: MockNewsListViewController!
    var newsSearchManager: MockNewsSearchManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockNewsListViewController()
        newsSearchManager = MockNewsSearchManager()
        
        sut = NewsListPresenter(viewController: viewController, newsSearchManager: newsSearchManager)
    }
    
    override func tearDown() {
        sut = nil
        newsSearchManager = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_요청될때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_didPulledRefreshControl가_요청될때_request에_실패하면() {
        newsSearchManager.error = NSError() as Error
        sut.didPulledRefreshControl()
        
        XCTAssertFalse(viewController.isCalledReloadTableView)
        XCTAssertFalse(viewController.isCalledEndRefreshing)
        
    }
    
    func test_didPulledRefreshControl가_요청될때_request에_성공하면() {
        newsSearchManager.error = nil
        sut.didPulledRefreshControl()
        
        XCTAssertTrue(viewController.isCalledReloadTableView)
        XCTAssertTrue(viewController.isCalledEndRefreshing)
    }
}
