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
        chatImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.iconImageSize)
            make.width.equalTo(Constants.iconImageSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(chatImageView.snp.bottom).inset(8)
        }
    }
}
