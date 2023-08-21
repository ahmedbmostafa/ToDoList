//
//  ToDoModel.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import Foundation

struct ToDo: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    var title: String
    var toDoDetails: [ToDoDetails]
}

struct ToDoDetails: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var completed: Bool = false
}
