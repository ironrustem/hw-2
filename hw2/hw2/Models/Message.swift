//
//  Message.swift
//  hw2
//
//  Created by wrustem on 06.10.2021.
//

import Foundation

struct Message {
    let text: String
    let date: Date
    let type: MessageType
}

enum MessageType {
    case send, get
}
