//
//  TaskListView.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/5/22.
//

import SwiftUI

struct TaskListView: View {
    // MARK: - PROPERTY
    @State private var tasks: [Task] = [Task]()
    @State private var text: String = ""
    
    // MARK: - FUNCTION
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
//        dump(tasks)
        
        do {
            let data = try JSONEncoder().encode(tasks)
            let url = getDocumentDirectory().appendingPathComponent("tasks")
            try data.write(to: url)
        } catch {
            print("Failed saving data")
        }
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
    
    func delete(offsets: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: offsets)
            save()
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        let height = tasks.count * 50
        VStack {
            List {
                ForEach(0..<tasks.count, id: \.self) { i in
                    HStack {
                        Capsule()
                            .frame(width: 4)
                            .background(Color.black)
                        Text(tasks[i].text)
                            .lineLimit(1)
                            .padding(.leading, 5)
                            .foregroundColor(Color("TaskTextColor"))
                    }
                }
                .onDelete(perform: delete)
                .listRowBackground(
                    Color(.white)
                        .cornerRadius(10.0)
                        .opacity(0.7)
                )
                .foregroundColor(Color.black)
            }
            .frame(height: CGFloat(height))
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Task", text: $text)
                    .background(Color.white)
                    .opacity(0.7)
                    .cornerRadius(10.0)
                Button {
                    // ACTION
                    guard text.isEmpty == false else { return }
                    let task = Task(id: UUID(), text: text)
                    tasks.append(task)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                        .foregroundColor(Color.white)
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
//                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
            }
        }
        .onAppear(perform: {
            load()
        })
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
