//
//  SettingsView.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/26/21.
//

import SwiftUI

struct Settings: View {
    
    
    @State private var showLargeIcons = true
    var body: some View {
        ScrollView {
            Toggle("Big Icons", isOn: $showLargeIcons)
        }
        .navigationBarTitle("Settings")
    }
}
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
