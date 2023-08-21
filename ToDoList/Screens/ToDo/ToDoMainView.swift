//
//  ToDoMainView.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import SwiftUI
import WaterfallGrid
import IQKeyboardManagerSwift

struct ToDoMainView: View {
    
    @EnvironmentObject var dataStore: DataStore
    @State var isFabTapped = false
    var gridItemLayoutSingle = [GridItem(.flexible())]
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationView {
            
            ZStack (alignment: .bottom){
                
                VStack (alignment: .leading) {
                    
                    MainNavigationBar()
                    
                    ToDosScrollView(toDos: $dataStore.toDos)
                    
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color("ColorThemeTop"), Color("ColorThemeBott")]), startPoint: .top, endPoint: .bottom))
                
                FabView(isFabTapped: $isFabTapped)
            }
        }
        .onAppear{IQKeyboardManager.shared.enable = true}
    }
}

// MARK: - Preview

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoMainView()
            .environmentObject(DataStore())
    }
}

// MARK: - MainNavigationBar

struct MainNavigationBar: View {
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            HStack(spacing: 14) {
                Image("Union")
                    .frame(width: 25.5, height: 26)
                
                Text("Todo Lists")
                    .font(.custom("MontserratAlternates-SemiBold", size: 31))
                    .foregroundColor(Color("ColorBot"))
                
                Spacer()
                
                Image("Ellipse 2")
                    .frame(width: 25.5, height: 26)
                    .onTapGesture {
                        let currentTheme = AppSettings.shared.currentTheme
                        AppSettings.shared.currentTheme = currentTheme == .light ? .dark : .light
                    }.accessibilityIdentifier("changeTheme")
                
            }
            
            Text("Plan to get a more meaningful life")
                .font(.custom("MontserratAlternates-Regular", size: 14))
                .foregroundColor(Color("ColorTxt"))
                .padding(.top, 10)
            
            Rectangle()
                .opacity(0.5)
                .foregroundColor(Color("ColorTxt"))
                .frame(width: 102,height: 4,alignment: .leading)
            
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 30, trailing: 16))
    }
}

// MARK: - ToDosScrollView

struct ToDosScrollView: View {
    
    @Binding var toDos: [ToDo]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            WaterfallGrid(toDos) { item in
                
                NavigationLink {
                    // destination
                    ToDoDetailsView(formVM: ToDoDetailsViewModel(item, updating: true), toDoTitle: item.title)
                } label: {
                    // action on
                    GridView(viewModel: GridViewModel(toDo: item))
                }
                
            }
            .gridStyle(
                columnsInPortrait: 2,
                columnsInLandscape: 2,
                spacing: 16,
                animation: .none
            )
            .scrollOptions(direction: .vertical)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

// MARK: - FabView

struct FabView: View {
    
    @Binding var isFabTapped: Bool
    
    var body: some View {
        
        Image("fab")
            .frame(width: 52, height: 52)
            .padding(.bottom, 40)
            .onTapGesture {
                print("fab")
                isFabTapped.toggle()
            }.accessibilityIdentifier("fabBtn")
        
        let toDoDetails = [ToDoDetails(name: "")]
        let toDo = ToDo(title: "Untitled", toDoDetails: toDoDetails)
        
        NavigationLink("", destination: ToDoDetailsView(formVM: ToDoDetailsViewModel(toDo,updating: false), toDoTitle: "Untitled"), isActive: $isFabTapped)
    }
}
