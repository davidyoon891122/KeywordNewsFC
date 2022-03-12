//
//  NewsRequestModel.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/12.
//

import Foundation

struct NewsRequestModel: Codable {
    /// 검색어
    let query: String
    /// 시작 Index, 1 ~ 1000
    let start: Int
    /// 검색 결과 출력 건수, 10 ~ 100
    let display: Int
}
