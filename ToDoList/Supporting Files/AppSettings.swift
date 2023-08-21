//
//  AppSettings.swift
//  ToDoList
//
//  Created by Ahmed on 20/08/2023.
//

import SwiftUI

enum Theme: Int {
    case light
    case dark
    
    var colorScheme: ColorScheme {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

class AppSettings: ObservableObject {

    static let shared = AppSettings()
    
    @AppStorage("current_theme") var currentTheme: Theme = .light
}

