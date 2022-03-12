//
//  String+.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/12.
//

import Foundation

extension String {
    var htmlToString: String {
        guard let data = data(using: .utf8) else { return "" }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue
                         ],
                documentAttributes: nil
            ).string
        } catch {
            return ""
        }
    }
}
