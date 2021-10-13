//
//  PinnedChatsCell.swift
//  hw2
//
//  Created by wrustem on 12.10.2021.
//

import UIKit

protocol PinnedChatsDelegate: AnyObject {
    func chatTapped(index: Int)
}

class PinnedChatsCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let pinnedChatCellReuseIdentifier = "pinnedChatCellReuseIdentifier"
        static let titleLabelInset = UIEdgeInsets(top: 11, left: 24, bottom: 0, right: -24)
        static let collectionViewInset = UIEdgeInsets(top: 16, left: 24, bottom: -20, right: -24)
    }
    
    weak var delegate: PinnedChatsDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularTitle)
        label.text = "PINNED"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: 48, height: 72)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PinnedChatCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.pinnedChatCellReuseIdentifier)
        collectionView.backgroundColor = .clear
                
        return collectionView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(separatorView)
    }
    
    func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.titleLabelInset.top).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.titleLabelInset.right).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.titleLabelInset.left).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.collectionViewInset.top).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.collectionViewInset.right).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.collectionViewInset.left).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constants.collectionViewInset.bottom).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension PinnedChatsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.chatTapped(index: indexPath.row)
    }
}

extension PinnedChatsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.pinnedChatCellReuseIdentifier,
            for: indexPath) as? PinnedChatCollectionViewCell {
            cell.config(image: Asset.profilePhoto.image)
            return cell
        }
        return UICollectionViewCell()
    }
}

final class FitContentTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        layoutSubviews()
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }
}
