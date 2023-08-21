//
//  GridViewModel.swift
//  ToDoList
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation

class GridViewModel: ObservableObject {
    
    @Published var toDo: ToDo!
    
    init(toDo: ToDo) {
        self.toDo = toDo
    }
    
    var doneTaks: String {
        let totalCount = toDo.toDoDetails.count
        let completedCount = toDo.toDoDetails.filter({ $0.completed}).count
        return "\(completedCount)/\(totalCount) Done"
    }
    
}
