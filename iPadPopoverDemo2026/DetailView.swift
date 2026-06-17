//
//  DetailView.swift
//  iPadPopoverDemo2026
//
//  Created by Douglas Jasper on 2026-06-17.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var settings: SettingsStore
    let selectedItem: String

    // Popover state
    @State private var showingPopover = false

    // For iPad pointer/hover visual feedback we add hover state
    @State private var isHoveringButton = false

    var body: some View {
        VStack(spacing: 16) {
            header
            content
            Spacer()
        }
        .padding()
        .navigationTitle(selectedItem)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                // Put the popover on this button
                Button {
                    showingPopover = true
                } label: {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                        .accessibilityLabel("Show settings")
                        .padding(8)
                }
                // Popover anchored to the button's bounds
                .popover(isPresented: $showingPopover,
                         attachmentAnchor: .rect(.bounds),
                         arrowEdge: .top) {
                    SettingsPopoverView(isPresented: $showingPopover)
                        .environmentObject(settings)
                        .frame(minWidth: 320, idealWidth: 360, maxWidth: 420,
                               minHeight: 220, idealHeight: 260, maxHeight: 380)
                }
                .onHover { over in
                    // pointer feedback on iPad trackpad/mouse
                    withAnimation(.easeInOut(duration: 0.12)) { isHoveringButton = over }
                }
                .scaleEffect(isHoveringButton ? 1.06 : 1.0)
                .buttonStyle(.plain)
            }
        }
        .background(backgroundView)
        .dynamicTypeSize(.medium ... .accessibility3) // allow up to big accessibility sizes
        .environment(\.sizeCategory, .large)
        .preferredColorScheme(preferredColorScheme(for: settings.theme))
    }

    private var header: some View {
        HStack {
            Text("Detail")
                .font(.title)
                .bold()
            Spacer()
            Text("Font: \(Int(settings.fontSize)) pt")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var content: some View {
        VStack(spacing: 12) {
            Text("This is a demo detail view for \(selectedItem).")
                .font(.system(size: CGFloat(settings.fontSize)))
                .multilineTextAlignment(.center)
            if settings.showGrid {
                GridPlaceholder()
                    .frame(height: 220)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1))
                    .frame(height: 220)
                    .overlay(Text("Grid hidden").foregroundStyle(.secondary))
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder private var backgroundView: some View {
        // subtle background that respects theme
        Color(UIColor.systemBackground)
    }

    private func preferredColorScheme(for theme: SettingsStore.Theme) -> ColorScheme? {
        switch theme {
        case .automatic: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

// small decorative grid to show the effect of showGrid
struct GridPlaceholder: View {
    var body: some View {
        GeometryReader { geo in
            let cols = 4
            let spacing: CGFloat = 8
            let totalSpacing = CGFloat(cols - 1) * spacing
            let w = (geo.size.width - totalSpacing) / CGFloat(cols)
            VStack(spacing: spacing) {
                ForEach(0..<3) { _ in
                    HStack(spacing: spacing) {
                        ForEach(0..<cols) { _ in
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.quaternary)
                                .frame(width: w, height: w * 0.7)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    DetailView(selectedItem: "Preview Item")
        .environmentObject(SettingsStore())
}
