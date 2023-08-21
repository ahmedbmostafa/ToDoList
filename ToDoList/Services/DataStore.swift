//
//  DataStore.swift
//  ToDoList
//
//  Created by Ahmed on 20/08/2023.
//

import Foundation

protocol DataStorable {
    func addToDo(_ toDo: ToDo)
    func updateToDo(_ toDo: ToDo)
    func deleteToDo(_ toDo: ToDo)
    func loadToDos()
}

class DataStore: ObservableObject, DataStorable {
    @Published var toDos:[ToDo] = []
    
    init() {
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName){
            loadToDos()
        }
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.append(toDo)
        saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == toDo.id}) else { return }
        toDos[index] = toDo
        print("updating ...")
        saveToDos()
    }
    
    func deleteToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: { $0.id == toDo.id}) else { return }
        toDos.remove(at: index)
        print("deleting ...")
        saveToDos()
    }
    
    func loadToDos() {
        
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    print("loading ...")
                    toDos = try decoder.decode([ToDo].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveToDos() {
        print("Saving toDos to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDos)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
