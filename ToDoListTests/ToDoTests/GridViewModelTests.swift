//
//  GridViewModelTests.swift
//  ToDoListTests
//
//  Created by Ahmed on 20/08/2023.
//

import XCTest
@testable import ToDoList

 class GridViewModelTests: XCTestCase {

    var viewModel: GridViewModel!
    
    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func testCompletedToDo() {
        let completedToDo: Data = Data(completedToDo.utf8)
        let toDos = try! JSONDecoder().decode(ToDo.self, from: completedToDo)
        viewModel = GridViewModel(toDo: toDos)
        XCTAssertTrue(viewModel.doneTaks == "1/1 Done")
    }

    func testUnCompletedToDo() {
        let unCompletedToDo: Data = Data(unCompletedToDo.utf8)
        let toDos = try! JSONDecoder().decode(ToDo.self, from: unCompletedToDo)
        viewModel = GridViewModel(toDo: toDos)
        XCTAssertTrue(viewModel.doneTaks == "0/1 Done")
    }
    
}
