//
//  SettingsPopoverView.swift
//  iPadPopoverDemo2026
//
//  Created by Douglas Jasper on 2026-06-17.
//

import SwiftUI

import SwiftUI

struct SettingsPopoverView: View {
    @EnvironmentObject var settings: SettingsStore
    @Binding var isPresented: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $settings.theme) {
                        ForEach(SettingsStore.Theme.allCases) { t in
                            Text(t.rawValue).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Content")) {
                    Toggle("Show grid", isOn: $settings.showGrid)
                    HStack {
                        Text("Font size")
                        Slider(value: $settings.fontSize, in: 12...30, step: 1)
                        Text("\(Int(settings.fontSize))")
                            .frame(minWidth: 36, alignment: .trailing)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        isPresented = false
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
        }
        .interactiveDismissDisabled(false) // allow tap outside to dismiss on iPad
    }
}

#Preview {
    SettingsPopoverView(isPresented: .constant(true))
        .environmentObject(SettingsStore())
}
