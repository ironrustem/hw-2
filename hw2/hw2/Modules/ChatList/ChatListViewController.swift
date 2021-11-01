//
//  ChatListViewController.swift
//  hw2
//
//  Created by wrustem on 12.10.2021.
//

import UIKit

class ChatListViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let searchBarCancelButtonTextKey = "cancelButtonText"
        static let pinnedChatCellReuseIdentifier = "pinnedChatCellReuseIdentifier"
        static let chatCellReuseIdentifier = "chatCellReuseIdentifier"
        static let keyboardOffsetDelta: CGFloat = 25.0
    }
    
    private lazy var tableView: FitContentTableView = {
        let tableView = FitContentTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(PinnedChatsCell.self,
                           forCellReuseIdentifier: Constants.pinnedChatCellReuseIdentifier)
        tableView.register(ChatCell.self,
                           forCellReuseIdentifier: Constants.chatCellReuseIdentifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Text.ChatList.searchController
        searchController.searchBar.setValue(Text.Common.cancel, forKey: Constants.searchBarCancelButtonTextKey)
        definesPresentationContext = true
        return searchController
    }()
    
    private var keyboardHeiht: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        addSubViews()
        makeConstraints()
        registerForKeyboardNotifications()
        setGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configNavigationBar() {
        navigationItem.searchController = searchController
        view.backgroundColor = Asset.Colors.backGround.color
        navigationItem.title = Text.ChatList.title
        
        let sendButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back))
        sendButton.image = Asset.backIcon.image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = sendButton
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration:TimeInterval = (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame.origin.y = -kbFrameSize.height + Constants.keyboardOffsetDelta
        })
    }
    
    @objc func kbWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo
        let duration:TimeInterval = (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame.origin.y = 0
        })
    }
    
    func addSubViews() {
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDelegate

extension ChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != .zero else {
            return
        }
        
        navigationController?.pushViewController(ChatViewController(), animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ChatListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero,
           let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.pinnedChatCellReuseIdentifier,
            for: indexPath) as? PinnedChatsCell {
            return cell
        } else if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.chatCellReuseIdentifier,
            for: indexPath) as? ChatCell {
            return cell
        }
        
        return UITableViewCell()
    }
}

