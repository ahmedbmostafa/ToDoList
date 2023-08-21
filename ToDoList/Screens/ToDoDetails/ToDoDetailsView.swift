//
//  ToDoDetailsView.swift
//  ToDoList
//
//  Created by Ahmed on 19/08/2023.
//

import SwiftUI

struct ToDoDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: ToDoDetailsViewModel
    @State var toDoTitle: String
    
    var maxHeight = UIScreen.main.bounds.height * 0.62
    var minHeight = UIScreen.main.bounds.height * 0.15
    
    // MARK: - body
    
    var body: some View {
        
        VStack {
            ZStack (alignment: .topLeading){
                
                MainBackground(maxHeight: maxHeight)
                
                VStack (alignment: .leading){
                    
                    MainTitle(toDoTitle: $toDoTitle)
                    
                    ToDoDetailsList(formVM: formVM, presentationMode: presentationMode, dataStore: dataStore, maxHeight: maxHeight)
                    
                    DoneResetView(formVM: formVM, dataStore: dataStore)
                }
                .frame(height: maxHeight)
            }
            
            Spacer()
            
            AddToDoComponent(formVM: formVM, toDoTitle: $toDoTitle, presentationMode: presentationMode, dataStore: dataStore, minHeight: minHeight)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackView(formVM: formVM, toDoTitle: $toDoTitle, presentationMode: presentationMode, dataStore: dataStore))
        .background(LinearGradient(gradient: Gradient(colors: [Color("ColorThemeTop"), Color("ColorThemeBott")]), startPoint: .top, endPoint: .bottom))
    }
    
}

// MARK: - MainBackground

struct MainBackground: View {
    
    var maxHeight: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorTop"), Color("ColorBot")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(12)
            .shadow(color: Color("ColorShadow"), radius: 6, x: 8, y: 14)
            .frame(height: maxHeight,alignment: .top)
    }
    
}

// MARK: - MainTitle

struct MainTitle: View {
    
    @Binding var toDoTitle: String
    
    var body: some View {
        TextField("Untitled", text: $toDoTitle)
            .font(.custom("MontserratAlternates-SemiBold", size: 24))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 28, leading: 20, bottom: 0, trailing: 10))
    }
    
}

// MARK: - ToDoDetailsList

struct ToDoDetailsList: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    var presentationMode: Binding<PresentationMode>
    var dataStore: DataStore
    var maxHeight: CGFloat
    
    var body: some View {
        
        List() {
            
            ForEach(($formVM.toDo.toDoDetails), id: \.self) { item in
                
                HStack {
                    
                    ToDoDetailsRowComponent(formVM: formVM, item: item, dataStore: dataStore)
                    
                    DeleteView(formVM: formVM, item: item, presentationMode: presentationMode, dataStore: dataStore)
                    
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading:20, bottom: 16, trailing: 20))
            
        }
        .frame(height: (maxHeight * 0.7))
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .clipped()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        
        Spacer()
    }
}

struct DoneResetView: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    var dataStore: DataStore
    
    var body: some View {
        
        HStack {
            Text(formVM.doneTaks)
                .font(.custom("MontserratAlternates-Regular", size: 14))
                .foregroundColor(.white)
            Spacer()
            
            Button {
                print("reset")
                dataStore.deleteToDo(formVM.toDo)
                formVM.toDo.toDoDetails.removeAll()
                
            } label: {
                Text("reset list")
                    .font(.custom("MontserratAlternates-Regular", size: 14))
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)

        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
    }
    
}

// MARK: - ToDoDetailsRowComponent

struct ToDoDetailsRowComponent: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    @Binding var item: ToDoDetails
    var dataStore: DataStore
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .fill(Color("ColorTxtFBack"))
                .cornerRadius(4)
                .frame(height: 52,alignment: .leading)
            
            HStack {
                
                Image( systemName: item.completed ? "checkmark.square" : "square")
                    .frame(width: 17, height: 18.5)
                    .onTapGesture {
                        if let index = formVM.toDo.toDoDetails.firstIndex(where: {$0 == item}) {
                            item.completed ? (formVM.toDo.toDoDetails[index].completed = false) : (formVM.toDo.toDoDetails[index].completed = true)
                            dataStore.updateToDo(formVM.toDo)
                        }
                    }
                    .padding(.leading, 18)
                
                ToDoDetailsRowView(itemTxt: item.name)
                    .padding(.leading, 0)
            }
        }
        
    }
}

// MARK: - AddToDoComponent

struct AddToDoComponent: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    @Binding var toDoTitle: String
    var presentationMode: Binding<PresentationMode>
    var dataStore: DataStore
    var minHeight: CGFloat
    
    var body: some View {
        
        ZStack (alignment: .topLeading){
            
            Rectangle()
                .fill(Color("ColorBot"))
                .cornerRadius(12)
                .shadow(color: Color("ColorShadow"), radius: 6, x: 8, y: 14)
                .frame(height: minHeight,alignment: .bottom)
                .padding(.bottom, 24)
            
            VStack (alignment: .leading){
                Text("Add new item")
                    .font(.custom("MontserratAlternates-Regular", size: 14))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                AddToDoView(formVM: formVM, toDoTitle: $toDoTitle, presentationMode: presentationMode, dataStore: dataStore)
                
            }
            .padding(.leading, 20)
        }
    }
}

// MARK: - AddToDoView

struct AddToDoView: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    @Binding var toDoTitle: String
    var presentationMode: Binding<PresentationMode>
    var dataStore: DataStore
    
    var body: some View {
        
        HStack {
            
            ZStack(alignment: .leading) {
                
                if $formVM.name.wrappedValue.isEmpty {
                    Text("Write here")
                        .foregroundColor(.white)
                        .font(.custom("MontserratAlternates-Regular", size: 14))
                        .padding(16)
                }
                
                TextField("", text: $formVM.name)
                    .foregroundColor(.white)
                    .font(.custom("MontserratAlternates-Regular", size: 14))
                    .padding(16)
        
            }
            .frame(height: 40)
            .background(Color("ColorTxtFBack"))
            .cornerRadius(4)
            
            Button {
                addBtnTapped()
            } label: {
                Text("ADD")
                    .font(.custom("MontserratAlternates-Bold", size: 14))
                    .foregroundColor(.white)
                    .frame(width: 82, height: 40)
                
            }
            .buttonStyle(.plain)
            .background(Color("ColorBtnBack"))
            .cornerRadius(4)
        }
        .padding(.trailing, 20)
    }
    
    func addBtnTapped() {
        
        if !$formVM.name.wrappedValue.isEmpty {
            var todoDetail: ToDoDetails
            todoDetail = ToDoDetails(name: formVM.name)
            formVM.toDo.toDoDetails.append(todoDetail)
            toDoTitle.isEmpty ?  (formVM.toDo.title = "Untitle") :  (formVM.toDo.title = toDoTitle)
            formVM.updating ? dataStore.updateToDo(formVM.toDo) : dataStore.addToDo(formVM.toDo)
            formVM.shouldDismiss ? self.presentationMode.wrappedValue.dismiss() :  print("shouldLoad=",formVM.shouldDismiss)
        }
        formVM.name = ""
    }
}

// MARK: - DeleteView

struct DeleteView: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    @Binding var item: ToDoDetails
    var presentationMode: Binding<PresentationMode>
    var dataStore: DataStore
    
    var body: some View {
        
        Image("Delete")
            .frame(width: 17, height: 18.5)
            .padding(.leading, 19)
            .onTapGesture {
                formVM.shouldDelete ? dataStore.deleteToDo(formVM.toDo) : print(formVM.shouldDelete)
                formVM.shouldDismiss ? self.presentationMode.wrappedValue.dismiss() :  print("shouldLoad=",formVM.shouldDismiss)
                
                if let index = formVM.toDo.toDoDetails.firstIndex(where: {$0 == item}) {
                    print(index)
                    formVM.toDo.toDoDetails.remove(at: index)
                    dataStore.updateToDo(formVM.toDo)
                }
            }
    }
}

// MARK: - BackView

struct BackView: View {
    
    @ObservedObject var formVM: ToDoDetailsViewModel
    @Binding var toDoTitle: String
    var presentationMode: Binding<PresentationMode>
    var dataStore: DataStore
    
    var body : some View {
        
        Button {
            formVM.mainTitle = toDoTitle
            if formVM.updateTitle {
                print("toDoTitle",toDoTitle)
                formVM.toDo.title = toDoTitle
                formVM.updating ? dataStore.updateToDo(formVM.toDo) : dataStore.addToDo(formVM.toDo)
            }
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image("ArrowLeft")
        }
        .frame(width: 24, height: 24)
        .accessibilityIdentifier("backBtn")
    }
}
