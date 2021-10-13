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
        static let tableViewInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: -19)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        addSubViews()
        makeConstraints()
        getMessages()
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
    }
    
    func addSubViews() {
        view.addSubview(messageFiledView)
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        messageFiledView.translatesAutoresizingMaskIntoConstraints = false
        messageFiledView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        messageFiledView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        messageFiledView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: messageFiledView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                           constant: Constants.tableViewInset.left).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: Constants.tableViewInset.right).isActive = true
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
