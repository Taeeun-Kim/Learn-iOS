//
//  DataStore.swift
//  CombineToDoList
//
//  Created by Taeeun Kim on 07.11.21.
//

import Foundation

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    
    init() {
        loadToDos()
    }
    
    func addToDo(_ toDo: ToDo) {
        
    }
    
    func updateToDo(_ toDo: ToDo) {
        
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        
    }
    
    func loadToDos() {
        toDos = ToDo.sampleData
    }
    
    func saveToDos() {
        print("Saving toDos to file system eventually")
    }
}
