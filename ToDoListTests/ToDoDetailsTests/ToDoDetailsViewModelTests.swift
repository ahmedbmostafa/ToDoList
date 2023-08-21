//
//  ToDoDetailsViewModelTests.swift
//  ToDoListTests
//
//  Created by Ahmed on 21/08/2023.
//

import XCTest
@testable import ToDoList

 class ToDoDetailsViewModelTests: XCTestCase {

    var viewModel: ToDoDetailsViewModel!
    var toDos: ToDo!
     
    override func setUp() {
        super.setUp()
        let completedToDo: Data = Data(completedToDo.utf8)
         toDos = try! JSONDecoder().decode(ToDo.self, from: completedToDo)
        viewModel = ToDoDetailsViewModel(toDos, updating: true)

    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
     
     func testToDoName() {
         viewModel.name = toDos.toDoDetails.first?.name ?? ""
         XCTAssertTrue(viewModel.name == "HomeToDo")
     }
     
     func testShouldDismiss() {
         XCTAssertTrue(viewModel.shouldDismiss == false)
     }
     
     func testShouldDelete() {
         XCTAssertTrue(viewModel.shouldDelete == true)
     }
    
     func testUpdateTitle() {
         viewModel.mainTitle = toDos.title
         XCTAssertTrue(viewModel.updateTitle == true)
     }
     
     func testCompletedToDo() {
         XCTAssertTrue(viewModel.doneTaks == "1/1 Done")
     }

      func testUnCompletedToDo() {
          let unCompletedToDo: Data = Data(unCompletedToDo.utf8)
           toDos = try! JSONDecoder().decode(ToDo.self, from: unCompletedToDo)
          viewModel = ToDoDetailsViewModel(toDos, updating: true)
          XCTAssertTrue(viewModel.doneTaks == "0/1 Done")
      }
  
}
