//
//  ContentView.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/4/22.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView {
            PomodoroView()
            ShortBreakView()
            LongBreakView()
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct RowView: View {
    @State private var taskComplete = false
    let task: String
    var body: some View {
        HStack {
            Button(action: {
                taskComplete.toggle()
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color(taskComplete ? "PomodoroBackgroundColor" : "UnfinishedTaskIconColor"))
                Text(task)
                Spacer()
            }
        }
        .foregroundColor(Color("TaskTextColor"))
        .frame(width: 180.0, height: 40.0)
        .background(Color.white)
        .cornerRadius(5.0)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
