//
//  ToDoDetailsViewModel.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import Foundation

class ToDoDetailsViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var toDo: ToDo!
    @Published var updating = false
    @Published var mainTitle = ""

    var shouldDismiss: Bool {
        !updating
    }
    
    var shouldDelete: Bool {
        return toDo.toDoDetails.count == 1
    }
    
    var updateTitle: Bool {
        return (mainTitle != "Untitled" && mainTitle != "" && toDo.toDoDetails.count > 0)
    }
    
    var doneTaks: String {
        let totalCount = toDo.toDoDetails.count
        let completedCount = toDo.toDoDetails.filter({ $0.completed}).count
        return "\(completedCount)/\(totalCount) Done"
    }
    
    init() {}
    
    init(_ currentToDo: ToDo, updating: Bool) {
        self.toDo = currentToDo
        self.updating = updating
        if updating == false {
            self.toDo.toDoDetails = []
        }
    }
}
