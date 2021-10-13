//
//  PinnedChatCollectionViewCell.swift
//  hw2
//
//  Created by wrustem on 12.10.2021.
//

import UIKit

class PinnedChatCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let iconImageSize = CGSize(width: 48, height: 48)
        
    }
    
    private lazy var chatImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularTitle)
        label.text = "Kim"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(image: UIImage) {
        chatImageView.image = image
    }
    
    private func addSubviews() {
        contentView.addSubview(chatImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        chatImageView.translatesAutoresizingMaskIntoConstraints = false
        chatImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        chatImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        chatImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        chatImageView.heightAnchor.constraint(equalToConstant: Constants.iconImageSize.height).isActive = true
        chatImageView.widthAnchor.constraint(equalToConstant: Constants.iconImageSize.width).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: chatImageView.bottomAnchor, constant: 8).isActive = true
        
    }
}
