//
//  DataStore.swift
//  CombineToDoList
//
//  Created by Taeeun Kim on 07.11.21.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    @Published var appError: ErrorType? = nil
    var addToDo = PassthroughSubject<ToDo, Never>()
    var updateToDo = PassthroughSubject<ToDo, Never>()
    var deleteToDo = PassthroughSubject<IndexSet, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        print(FileManager.docDirURL.path)
        addSubscriptions()
        if FileManager().docExist(named: fileName) {
            loadToDos()
        }
    }
    
    func addSubscriptions() {
        $toDos
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: DispatchQueue.main)
            .encode(encoder: JSONEncoder)
            .tryMap { data in
                try data.write(to: FileManager)
            }
        
        addToDo
            .sink { [unowned self] toDo in
                toDos.append(toDo)
                saveToDos()
            }
            .store(in: &subscriptions)
        
        updateToDo
            .sink { [unowned self] toDo in
                guard let index = toDos.firstIndex(where: { $0.id == toDo.id}) else { return }
                toDos[index] = toDo
                saveToDos()
            }
            .store(in: &subscriptions)
        
        deleteToDo
            .sink { [unowned self] indexSet in
                toDos.remove(atOffsets: indexSet)
                saveToDos()
            }
            .store(in: &subscriptions)
    }
    
    func loadToDos() {
        FileManager().readDocument(docName: fileName) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    toDos = try decoder.decode([ToDo].self, from: data)
                } catch {
//                    print(ToDoError.decodingError.localizedDescription)
                    appError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
//                print(error.localizedDescription)
                appError = ErrorType(error: error)
            }
        }
    }
    
    func saveToDos() {
        print("Saving toDos to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(toDos)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { error in
                if let error = error {
//                    print(error.localizedDescription)
                    appError = ErrorType(error: error)
                }
            }
        } catch {
//            print(ToDoError.encodingError.localizedDescription)
            appError = ErrorType(error: .encodingError)
        }
        
    }
}
