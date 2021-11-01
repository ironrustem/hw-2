//
//  ChatCell.swift
//  hw2
//
//  Created by wrustem on 13.10.2021.
//

import UIKit

class ChatCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let iconImageSize = CGSize(width: 50, height: 50)
        static let containerViewInset = UIEdgeInsets(top: 26, left: 24, bottom: 26, right: 24)
        
    }
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.profilePhoto.image
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularTitle)
        label.text = "Jessica Thompson"
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularTitle)
        label.text = "Hey you! Are u there?"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularSubtitle)
        label.text = "4h ago"
        label.textAlignment = .right
        return label
    }()
    
    lazy var firstLineElementsStackView: UIStackView = {
        let arrangedSubviews = [titleLabel, timeLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let arrangedSubviews = [firstLineElementsStackView, descriptionLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(iconImageView)
        view.addSubview(mainStackView)
        return view
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubviews()
        makeConstraints()
        backgroundColor = .clear
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    //        func config(with viewModel: Message) {
    //            titleLabel.text = viewModel.text
    //            dateLabel.text = StandardDateHandler.getTimeMessage(date: viewModel.date)
    //        }
    
    func addSubviews() {
        contentView.addSubview(containerView)
        contentView.addSubview(separatorView)
    }
    
    func makeConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(containerView)
            make.height.equalTo(Constants.iconImageSize)
            make.width.equalTo(Constants.iconImageSize)
        }
        mainStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(containerView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview().inset(Constants.containerViewInset)
            make.bottom.equalTo(separatorView).inset(Constants.containerViewInset)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
