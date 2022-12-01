//
//  RealmManager.swift
//  WeSplit
//
//  Created by Aaron Ward on 2022-12-01.
//

import Foundation

import RealmSwift

class RealmManager: ObservableObject{
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init(){
        openRealm()
        getTasks()
    }
    
    func openRealm(){
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            
            localRealm = try Realm()
        }catch{
            print("error opening Realm:  \(error)")
        }
    }
    
    
    func addTask(taskTitle: String){
        if let localRealm = localRealm {
            do{
                try localRealm.write {
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask)
                    getTasks()
                    print("added new task to Realm: \(newTask)")
                }
            }catch{
                print("Error adding task to Realm:  \(error)")
            }
        }
    }
    
    
    func getTasks(){
        if let localRealm = localRealm {
          let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    func updateTask(id: ObjectId, completed: Bool){
        if let localRealm = localRealm {
            do{
                
                // This line gets to task object you are selecting (Self) and then matches it with its Object ID to perform an action
              let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else {return}
                try localRealm.write{
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated  task to id: \(id)! Completed status: \(completed)")
                }
                
            }catch{
                print("added new task to Realm: \(id) to Realm: \(error)")

            }
        }
    }
    
    func deleteTask(id: ObjectId){
        if let localRealm = localRealm {
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                  guard !taskToDelete.isEmpty else {return}
                try localRealm.write(){
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task with ID: \(id) to Realm: \(id)")
                }
            }
            catch{
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
    
    
}
