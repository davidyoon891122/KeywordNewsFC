//
//  NewsListTableViewCell.swift
//  KeywordNews
//
//  Created by David Yoon on 2022/03/10.
//

import UIKit
import SnapKit

final class NewsListTableViewCell: UITableViewCell {
    static let identifier = "NewsListTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        return label
    }()
    
    func setup(news: News) {
        setupViews()
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        titleLabel.text = news.title.htmlToString
        descriptionLabel.text = news.description.htmlToString
        dateLabel.text = news.pubDate
    }
    
}

private extension NewsListTableViewCell {
    func setupViews() {
        [titleLabel, descriptionLabel, dateLabel]
            .forEach {
                addSubview($0)
            }
        let superViewInset: CGFloat = 16.0
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(48.0)
            $0.top.equalToSuperview().inset(superViewInset)
        }
        
        let verticalSpacing: CGFloat = 4.0
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel).offset(verticalSpacing)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel)
            $0.trailing.equalTo(descriptionLabel)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }
    }
}
