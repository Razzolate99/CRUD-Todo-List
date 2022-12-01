//
//  TasksView.swift
//  WeSplit
//
//  Created by Aaron Ward on 2022-12-01.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var relamManager: RealmManager
    var body: some View {
        VStack{
            Text("My Tasks")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List{
                ForEach(relamManager.tasks, id: \.id) {
                    task in
                    if !task.isInvalidated{
                        TaskRow(task: task.title,
                                completed: task.completed)
                        .onTapGesture {
                            relamManager.updateTask(id: task.id, completed: !task.completed)
                        }
                        .swipeActions(edge: .trailing){
                            Button(role: .destructive){
                                relamManager.deleteTask(id: task.id)
                            }label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                   
                }
                .listRowSeparator(.hidden)
                
            }
            .onAppear{
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(RealmManager())
    }
}
