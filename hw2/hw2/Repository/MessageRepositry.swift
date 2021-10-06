//
//  MessageRepositry.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import Foundation

class MessageRepository {
    static func get() -> [Message] {
        var messages = [Message]()
        messages.append(Message(text: "Hello, tomatto", date: Date(), type: .send))
        messages.append(Message(text: "Hello, burger!", date: Date(), type: .get))
        messages.append(Message(text: "How are you?", date: Date(), type: .send))
        messages.append(Message(text: "Really? You ask it me??? I AM BURGER!", date: Date(), type: .get))
        return messages
    }
}
