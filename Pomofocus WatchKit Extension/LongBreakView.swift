//
//  LongBreakView.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/5/22.
//

import SwiftUI

struct LongBreakView: View {
    @State var taskInput = ""
    @State private var keyboardIsShowing = false
    @State var tasks = ["Time to focus!"]
    
    var body: some View {
        ScrollView {
                LongBreakTimerView()
            HStack {
                Text("#1")
                    .font(.footnote)
                    .opacity(0.7)
                if tasks.count == 1 {
                    Text("\(tasks[0])")
                        .font(.footnote)
                } else {
                    Text("\(tasks[1])")
                }
            }
            .padding(.top, 2.0)
            .padding(.bottom, 10.0)
            Text("Tasks")
                .bold()
            Divider()
                .padding(.horizontal)
                .padding(.bottom, 2.0)
            VStack {
                let taskList = tasks.dropFirst()
                ForEach(taskList.indices, id: \.self) { i in
                    RowView(task: tasks[i])
                }
            }
            TextField("Add task", text: $taskInput)
                .padding(.horizontal)
            Button(action: {
                tasks.append(taskInput)
                taskInput = ""
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Task")
                }
            }
            .frame(height: 40.0)
            .cornerRadius(5.0)
            .padding(.horizontal)
        }
        .background(Color("LongBreakBackgroundColor"))
    }
}

struct LongBreakView_Previews: PreviewProvider {
    static var previews: some View {
        LongBreakView()
    }
}
