//
//  ToDoDetailsRowView.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import SwiftUI

struct ToDoDetailsRowView: View {
    
    var itemTxt: String
    
    var body: some View {
        
        Text(itemTxt)
            .foregroundColor(.white)
            .font(.custom("MontserratAlternates-Regular", size: 16))
            .padding(.leading, 6)
    }
}
