//
//  PomofocusApp.swift
//  Pomofocus WatchKit Extension
//
//  Created by Amy Kwak on 5/4/22.
//

import SwiftUI

@main
struct PomofocusApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
