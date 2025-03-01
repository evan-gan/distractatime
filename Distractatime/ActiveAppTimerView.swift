//
//  DistractionDetection.swift
//  Distractatime
//
//  Created by Evan Gan on 3/1/25.
//

import SwiftUI
import AppKit

struct ActiveAppTimerView: View {
    @State private var currentApp: String = "Unknown"
    @State private var elapsedTime: TimeInterval = 0
    @State private var lastActiveTime: Date? = nil
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Active App: \(currentApp)")
                .font(.headline)
            Text("Time Spent: \(formattedTime(elapsedTime))")
                .font(.subheadline)
        }
        .onReceive(timer) { _ in
            updateActiveApp()
        }
    }

    private func updateActiveApp() {
        if let activeApp = NSWorkspace.shared.frontmostApplication?.localizedName {
            if activeApp != currentApp {
                // If app changes, reset timer
                currentApp = activeApp
                elapsedTime = 0
                lastActiveTime = Date()
            } else if let startTime = lastActiveTime {
                // Update elapsed time
                elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }

    private func formattedTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
