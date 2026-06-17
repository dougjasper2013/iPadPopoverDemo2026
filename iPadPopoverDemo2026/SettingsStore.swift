//
//  SettingsStore.swift
//  iPadPopoverDemo2026
//
//  Created by Douglas Jasper on 2026-06-17.
//

import Foundation
import SwiftUI
import Combine

final class SettingsStore: ObservableObject {
    // Store theme as rawValue string
    @AppStorage("theme") var themeRaw: String = Theme.automatic.rawValue {
        didSet { objectWillChange.send() }
    }

    // Computed property for Theme enum
    var theme: Theme {
        get { Theme(rawValue: themeRaw) ?? .automatic }
        set {
            themeRaw = newValue.rawValue
        }
    }

    @AppStorage("showGrid") var showGrid: Bool = true {
        didSet { objectWillChange.send() }
    }

    @AppStorage("fontSize") var fontSize: Double = 18.0 {
        didSet { objectWillChange.send() }
    }

    enum Theme: String, CaseIterable, Identifiable {
        case automatic = "Automatic"
        case light      = "Light"
        case dark       = "Dark"

        var id: String { rawValue }
    }
}
