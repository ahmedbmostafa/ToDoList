//
//  ToDoListUITests.swift
//  ToDoListUITests
//
//  Created by Ahmed on 20/08/2023.
//

import XCTest

 class ToDoListUITests: XCTestCase {
     
    func testStaticComponents()  {
        let app = XCUIApplication()
        app.launch()
     
        let mainTitle = app.staticTexts["Todo Lists"]
        XCTAssert(mainTitle.exists)

        let changeThemeBtn = app.images["changeTheme"]
           XCTAssert(changeThemeBtn.exists)
        
        let fabBtn = app.images["fabBtn"]
           XCTAssert(fabBtn.exists)
        
    }
    
     func testToDoDetailsWithFabBtnTapped() {
         let app = XCUIApplication()
         app.launch()
         
         let mainTitle = app.staticTexts["Todo Lists"]
         XCTAssert(mainTitle.exists)
         
         app.images["fabBtn"].tap()
         
         let backBtn = app.buttons["backBtn"]
            XCTAssert(backBtn.exists)
         
         let resetBtn = app.buttons["reset list"]
            XCTAssert(resetBtn.exists)
         
         let AddNewItem = app.staticTexts["Add new item"]
         XCTAssert(AddNewItem.exists)
         
         let writeHere = app.staticTexts["Write here"]
         XCTAssert(writeHere.exists)
         
         let addBtn = app.buttons["ADD"]
            XCTAssert(addBtn.exists)
         
     }
     
     func testBackBtnTapped() {
         let app = XCUIApplication()
         app.launch()
         
         app.images["fabBtn"].tap()
         
         app.buttons["backBtn"].tap()
         
         let mainTitle = app.staticTexts["Todo Lists"]
         XCTAssert(mainTitle.exists)
     }
     
}

