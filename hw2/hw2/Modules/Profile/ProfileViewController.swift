//
//  ProfileViewController.swift
//  hw2
//
//  Created by wrustem on 13.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let descriptionLabelInset = UIEdgeInsets(top: 19, left: 25, bottom: 0, right: -25)
        static let logoutButtonSize = CGSize(width: 143, height: 36)
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        label.font = fontMetrics.scaledFont(for: .regularSubtitle)
        label.text = "Brooklyn, NY"
        label.textColor = Asset.Colors.profileDescription.color
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Asset.Colors.titleColor.color, for: .normal)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        button.titleLabel?.font = fontMetrics.scaledFont(for: .regularText)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitle(Text.Profile.logout, for: .normal)
        button.setImage(Asset.logout.image, for: .normal)
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 1
        button.layer.borderColor = Asset.Colors.black.color.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        addSubViews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubViews() {
        view.addSubview(descriptionLabel)
        view.addSubview(logoutButton)
    }
    
    private func makeConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.descriptionLabelInset.top).isActive = true
        descriptionLabel.leadingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.descriptionLabelInset.left).isActive = true
        descriptionLabel.trailingAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.descriptionLabelInset.right).isActive = true
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  view.bounds.height/6).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: Constants.logoutButtonSize.width).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: Constants.logoutButtonSize.height).isActive = true
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "Habibi", size: 40)]
        view.backgroundColor = Asset.Colors.backGround.color
        navigationItem.title = "Alex Tsimikas"
        
        let sendButton = UIBarButtonItem(title: Text.ChatList.title, style: .plain, target: self, action: #selector(goChatList))
        sendButton.tintColor = Asset.Colors.titleColor.color
        sendButton.setTitleTextAttributes([.font: UIFont(name: "Habibi", size: 20)],
        for: .normal)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = sendButton
    }
    
    @objc private func goChatList() {
        navigationController?.pushViewController(ChatListViewController(), animated: true)
    }
}
