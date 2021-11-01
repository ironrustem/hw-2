//
//  ChatViewController.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let messageSendCellReuseIdentifier = "messageSendCellReuseIdentifier"
        static let messageGetCellReuseIdentifier = "messageGetCellReuseIdentifier"
        static let tableViewInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 19)
        static let keyboardOffsetDelta: CGFloat = 25.0
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MessageSendCell.self,
                           forCellReuseIdentifier: Constants.messageSendCellReuseIdentifier)
        tableView.register(MessageGetCell.self,
                           forCellReuseIdentifier: Constants.messageGetCellReuseIdentifier)
        tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi))
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var messageFiledView: MessageFieldView = {
        let view = MessageFieldView()
        return view
    }()
    
    private var messages: [Message]?
    private var dictionaryMessage: [String: [Message]]?
    private var dates = [String]()
    
    private var keyboardHeiht: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        addSubViews()
        makeConstraints()
        getMessages()
        registerForKeyboardNotifications()
        setGestureRecognizer()
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
    
    func getMessages() {
        messages = MessageRepository.get()
        if let messages = messages {
            dictionaryMessage = Dictionary(grouping: messages, by: { StandardDateHandler.getDateMessage(date: $0.date)! })
            if let dictionaryMessage = dictionaryMessage {
                dates = Array(dictionaryMessage.keys)
            }
        }
        tableView.reloadData()
    }
    
    func configNavigationBar() {
        view.backgroundColor = Asset.Colors.backGround.color
        navigationItem.title = "Jessica Thompson"
        
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
            self.view.frame.origin.y = -kbFrameSize.height + Constants.keyboardOffsetDelta // Move view 150 points upward
            })
    }
    
    @objc func kbWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo
        let duration:TimeInterval = (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame.origin.y = 0 // Move view 150 points upward
            })
    }
    
    func addSubViews() {
        view.addSubview(messageFiledView)
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        messageFiledView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(messageFiledView.snp.top)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.tableViewInset)
        }
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dictionaryMessage?[dates[dates.count - section - 1]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = dictionaryMessage?[dates[dates.count - indexPath.section - 1]]?.count
        let model = dictionaryMessage?[dates[dates.count - indexPath.section - 1]]?[count! - indexPath.row - 1]
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.messageSendCellReuseIdentifier,
            for: indexPath) as? MessageSendCell ,
           let model = model,
           model.type == .send{
            cell.config(with: model)
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi))
            return cell
        } else if let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.messageGetCellReuseIdentifier,
            for: indexPath) as? MessageGetCell ,
                  let model = model,
                  model.type == .get{
            cell.config(with: model)
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = MessageHeaderView()
        header.configure(text: (dates[dates.count - section - 1] == StandardDateHandler.getDateMessage(date: Date()))
                         ? "TODAY" : dates[dates.count - section - 1])
        header.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi))
        return header
    }
}
