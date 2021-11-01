//
//  MessageGetCell.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import UIKit

class MessageGetCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let containerViewInset = UIEdgeInsets(top: -4, left: -8, bottom: -4, right: -8)
        static let profileImageViewSize = CGSize(width: 24, height: 24)
        static let titleLabelInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -10)
        static let dateLabelInset = UIEdgeInsets(top: 4, left: 0, bottom: 10, right: 0)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.getMessageText.color
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularTitle)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.profilePhoto.image
        return view
    }()
    
    private lazy var containerView: VariableCornerRadiusView = {
        let view = VariableCornerRadiusView()
        view.backgroundColor = Asset.Colors.getMessage.color
        view.topLeftRadius = 12
        view.topRightRadius = 12
        view.bottomRightRadius = 12
        view.bottomLeftRadius = 4
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .regularText
        label.textColor = Asset.Colors.getMessageTime.color
        label.textAlignment = .left
        return label
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
    
    func config(with viewModel: Message) {
        titleLabel.text = viewModel.text
        dateLabel.text = StandardDateHandler.getTimeMessage(date: viewModel.date)
    }
    
    func addSubviews() {
        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(profileImageView)
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(Constants.profileImageViewSize)
            make.width.equalTo(Constants.profileImageViewSize)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(Constants.titleLabelInset.left)
            make.trailing.equalToSuperview().offset(Constants.titleLabelInset.right)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(titleLabel).inset(Constants.containerViewInset)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(Constants.dateLabelInset.top)
            make.trailing.leading.equalTo(containerView)
            make.bottom.equalToSuperview().inset(Constants.dateLabelInset)
        }
    }
}
