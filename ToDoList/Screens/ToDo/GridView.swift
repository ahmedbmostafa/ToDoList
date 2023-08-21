//
//  GridView.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import SwiftUI

struct GridView: View {
    
    @ObservedObject var viewModel: GridViewModel
    var gridItemLayoutSingle = [GridItem(.flexible())]
    
    var body: some View {
        
        LazyVGrid(columns: gridItemLayoutSingle, alignment: .leading) {
            
            Text(viewModel.toDo.title)
                .font(.custom("MontserratAlternates-Bold", size: 14))
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 18, trailing: 20))
            
            ForEach(viewModel.toDo.toDoDetails, id: \.self) { item in
                
                Text(item.name)
                    .font(.custom("MontserratAlternates-Regular", size: 14))
                    .strikethrough(item.completed)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 10))
                
            }
            Text(viewModel.doneTaks)
                .font(.custom("MontserratAlternates-Regular", size: 14))
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))

        }
        .frame(alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color("ColorTop"), Color("ColorBot")]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(12)
        .shadow(color: Color("ColorShadow"), radius: 6, x: 8, y: 14)
        
    }
}
