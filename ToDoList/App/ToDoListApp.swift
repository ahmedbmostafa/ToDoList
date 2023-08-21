//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    @ObservedObject var appSettings = AppSettings.shared
    
    var body: some Scene {
        WindowGroup {
            ToDoMainView()
                .environmentObject(DataStore())
                .preferredColorScheme(appSettings.currentTheme.colorScheme)
        }
    }
    
}
