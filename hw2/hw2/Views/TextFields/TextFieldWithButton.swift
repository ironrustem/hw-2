//
//  TextFieldWithButton.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import UIKit

protocol TextFieldWithButtonDelegate: AnyObject {
    func buttonTapped()
}

class TextFieldWithButton: UITextField {
    
    // MARK: - Constants
    
    private enum Constants {
        static let buttonSize = CGSize(width: 32, height: 32)
        static let placeholderLabelInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
        static let sendButtonInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: -4)
    }
    
    // MARK: - Properties
    
    weak var _delegate: TextFieldWithButtonDelegate?
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.send.image, for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override var text: String? {
        didSet {
            setupPlaceholderLabel()
        }
    }
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularSubtitle)
        label.textColor = Asset.Colors.messageTextFieldText.color
        return label
    }()
    
    // MARK: - Initiallizers
    
    init(placeholder: String) {
        super.init(frame: CGRect())
        textColor = Asset.Colors.messageTextFieldText.color
        backgroundColor = Asset.Colors.messageTextField.color
        layer.cornerRadius = 18
        
        placeholderLabel.text = placeholder
        setupPlaceholderLabel()
        addTarget(self, action: #selector(setupPlaceholderLabel), for: .editingChanged)
        addSubviews()
        makeConstraints()
    }
    
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var textPadding = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 48
        )
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(placeholderLabel)
        addSubview(sendButton)
    }
    
    func makeConstraints() {
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.sendButtonInset.right).isActive = true
        sendButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.sendButtonInset.top).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.sendButtonInset.bottom).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize.height).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize.width).isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor,
                                                   constant: Constants.placeholderLabelInset.right).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: Constants.placeholderLabelInset.left).isActive = true
        placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        placeholderLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func sendButtonTapped() {
        _delegate?.buttonTapped()
    }
    
    @objc private func setupPlaceholderLabel() {
        if let text = text {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        placeholderLabel.isHidden = true
        return super.becomeFirstResponder()
    }
    
}
