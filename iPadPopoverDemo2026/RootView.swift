//
//  RootView.swift
//  iPadPopoverDemo2026
//
//  Created by Douglas Jasper on 2026-06-17.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var settings: SettingsStore // allows accessing SettingsStore

    // Example list content
    private let items = (1...12).map { "Item \($0)" }
    @State private var selected: String? = nil

    var body: some View {
        NavigationSplitView {
            List(selection: $selected) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Examples")
            .frame(minWidth: 260) // nice sidebar width on iPad
        } detail: {
            DetailView(selectedItem: selected ?? items.first!)
                .environmentObject(settings)
        }
        .navigationSplitViewStyle(.balanced) // forces DetailView to resize and accomodate the sidebar
    }
}

#Preview {
    RootView()
}
