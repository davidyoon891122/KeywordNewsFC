//
//  NewsSearchManager.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/12.
//

import Foundation
import Alamofire

protocol NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    )
}

struct NewsSearchManager: NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return }
        let parameters = NewsRequestModel(query: keyword, start: start, display: display)
        
       
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": clientID,
            "X-Naver-Client-Secret": clientSecret
        ]
        AF
            .request(
                url,
                method: .get,
                parameters: parameters,
                headers: headers
            )
            .responseDecodable(of: NewsResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    print(result.items)
                    completionHandler(result.items)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
        
    }
}
