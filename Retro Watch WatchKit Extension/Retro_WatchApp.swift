//
//  Retro_WatchApp.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import SwiftUI

@main
struct Retro_WatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
