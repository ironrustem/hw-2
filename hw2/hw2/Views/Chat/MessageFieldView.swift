//
//  MessageFieldView.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import UIKit

class MessageFieldView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let textFieldInset = UIEdgeInsets(top: 12, left: 16, bottom: 36, right: 16)
    }
    
    private lazy var textField: TextFieldWithButton = {
        let textField = TextFieldWithButton(placeholder: Text.Chat.MessageField.placeHolder)
        return textField
    }()
    
    
    // MARK: - Initiallization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        backgroundColor = Asset.Colors.mesageFieldView.color
        let border = UIView()
        border.backgroundColor = Asset.Colors.borderView.color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 1)
        addSubview(border)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    func addSubviews() {
        addSubview(textField)
    }
    
    func makeConstraints() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.textFieldInset)
        }
    }
}
