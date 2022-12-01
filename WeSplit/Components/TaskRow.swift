//
//  TaskRow.swift
//  WeSplit
//
//  Created by Aaron Ward on 2022-12-01.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var completed: Bool
    var body: some View {
        HStack{
            Image(systemName: completed ? "checkmark.circle" : "circle")
            
            Text(task)
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Do Laundry" , completed: true)
            
    }
}
