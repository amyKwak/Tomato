//
//  TaskList.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/5/22.
//

import SwiftUI
import CoreData

struct OLDTaskListView: View {
    var managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    
    var body: some View {
        FoodList().environment(\.managedObjectContext, managedObjectContext)
    }
}

struct FoodList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Food.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var foodList: FetchedResults<Food>
    
    var body: some View {
        ScrollView {
            ForEach(foodList, id: \.self) { food in
                NavigationLink(destination: EditFood(food: food).environment(\.managedObjectContext, self.managedObjectContext)) {
                    Text("\(food.name)")
                }
            }
            Button(action: {
                let food = Food(context: self.managedObjectContext)
                food.name = "New Food"
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
            }) {
                Text("Add Food")
            }
            .foregroundColor(Color.green)
        }
    }
}

struct EditFood: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var justEdited: Bool = false
    var food: Food
    
    var body: some View {
        VStack {
            TextField("Food Name", text: $name, onEditingChanged: { _ in
                self.justEdited = true
            }, onCommit: {
                self.justEdited = true
            }).onAppear {
                if !self.justEdited {
                    self.name = self.food.name
                }
                self.justEdited = false
            }
            Button(action: {
                self.food.name = self.name
                self.food.objectWillChange.send()
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
                
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }.foregroundColor(Color.green)
        }
    }
    
}

struct OLDTaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
