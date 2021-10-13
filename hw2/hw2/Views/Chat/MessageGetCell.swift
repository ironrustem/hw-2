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
        static let containerViewInset = UIEdgeInsets(top: -4, left: -8, bottom: 4, right: 8)
        static let profileImageViewSize = CGSize(width: 24, height: 24)
        static let titleLabelInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -10)
        static let dateLabelInset = UIEdgeInsets(top: 4, left: 0, bottom: -10, right: 0)
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
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageViewSize.height).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageViewSize.width).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                            constant: Constants.titleLabelInset.left).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: Constants.titleLabelInset.right).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor,
                                               constant: Constants.containerViewInset.left).isActive = true
        containerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                constant: Constants.containerViewInset.right).isActive = true
        containerView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Constants.containerViewInset.bottom).isActive = true
        containerView.topAnchor.constraint(equalTo: titleLabel.topAnchor,
                                                constant: Constants.containerViewInset.top).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.dateLabelInset.top).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: Constants.dateLabelInset.bottom).isActive = true
    }
}
