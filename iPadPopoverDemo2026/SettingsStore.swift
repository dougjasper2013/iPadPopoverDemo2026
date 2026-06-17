//
//  SettingsStore.swift
//  iPadPopoverDemo2026
//
//  Created by Douglas Jasper on 2026-06-17.
//

import Foundation
import SwiftUI
import Combine

// Simple ObservableObject to hold app settings
final class SettingsStore: ObservableObject {
    @Published var theme: Theme = .automatic // for storing sttings the user will select
    @Published var showGrid: Bool = true
    @Published var fontSize: Double = 18.0

    enum Theme: String, CaseIterable, Identifiable { // themes that can be selected
        case automatic = "Automatic"
        case light      = "Light"
        case dark       = "Dark"

        var id: String { rawValue }
    }
}
