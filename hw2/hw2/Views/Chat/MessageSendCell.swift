//
//  MessageSendCell.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import UIKit

class MessageSendCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let containerViewInset = UIEdgeInsets(top: -4, left: -8, bottom: 4, right: 8)
        static let titleLabelInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -8)
        static let dateLabelInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: -10)
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularTitle)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var containerView: VariableCornerRadiusView = {
        let view = VariableCornerRadiusView()
        view.backgroundColor = Asset.Colors.sentMessage.color
        view.topLeftRadius = 12
        view.topRightRadius = 12
        view.bottomLeftRadius = 12
        view.bottomRightRadius = 4
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .regularText
        label.textColor = Asset.Colors.sentMessageTime.color
        label.textAlignment = .right
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
    }
    
    func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: Constants.titleLabelInset.right).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Constants.titleLabelInset.left).isActive = true
        
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
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: Constants.dateLabelInset.bottom).isActive = true
    }
}

extension UIBezierPath {
    
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != 0 {
            path.move(to: CGPoint(x: topLeft.x + topLeftRadius, y: topLeft.y))
        } else {
            path.move(to: topLeft)
        }

        if topRightRadius != 0 {
            path.addLine(to: CGPoint(x: topRight.x - topRightRadius, y: topRight.y))
            path.addArc(tangent1End: topRight, tangent2End: CGPoint(x: topRight.x, y: topRight.y + topRightRadius), radius: topRightRadius)
        }
        else {
            path.addLine(to: topRight)
        }

        if bottomRightRadius != 0 {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - bottomRightRadius))
            path.addArc(tangent1End: bottomRight, tangent2End: CGPoint(x: bottomRight.x - bottomRightRadius, y: bottomRight.y), radius: bottomRightRadius)
        }
        else {
            path.addLine(to: bottomRight)
        }

        if bottomLeftRadius != 0 {
            path.addLine(to: CGPoint(x: bottomLeft.x + bottomLeftRadius, y: bottomLeft.y))
            path.addArc(tangent1End: bottomLeft, tangent2End: CGPoint(x: bottomLeft.x, y: bottomLeft.y - bottomLeftRadius), radius: bottomLeftRadius)
        }
        else {
            path.addLine(to: bottomLeft)
        }

        if topLeftRadius != 0 {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + topLeftRadius))
            path.addArc(tangent1End: topLeft, tangent2End: CGPoint(x: topLeft.x + topLeftRadius, y: topLeft.y), radius: topLeftRadius)
        }
        else {
            path.addLine(to: topLeft)
        }

        path.closeSubpath()
        cgPath = path
    }
}

open class VariableCornerRadiusView: UIView  {
    
    private func applyRadiusMaskFor() {
        let path = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }

    open var topLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    open var topRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    open var bottomLeftRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    open var bottomRightRadius: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        applyRadiusMaskFor()
    }
}
