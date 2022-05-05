//
//  PomodoroView.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/5/22.
//

import SwiftUI
import CoreData

struct PomodoroView: View {
    @State private var tasks: [Task] = [Task]()
    @State var taskTitle = "Time to focus"
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("tasks")
                let data = try Data(contentsOf: url)
                tasks = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                
            }
        }
    }
    
    var body: some View {
        ScrollView {
                PomodoroTimerView()
            HStack {
                Text("#1")
                    .font(.footnote)
                    .opacity(0.7)
                Text("\(taskTitle)")
                    .font(.footnote)
            }
            .padding(.top, 2.0)
            .padding(.bottom, 10.0)
            Text("Tasks")
                .bold()
            Divider()
                .padding(.horizontal)
                .padding(.bottom, 2.0)
            TaskListView()
                .padding(.horizontal)
        }
        .background(Color("PomodoroBackgroundColor"))
        .onAppear(perform: {
            load()
        })
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}
