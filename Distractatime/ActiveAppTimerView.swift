//
//  DistractionDetection.swift
//  Distractatime
//
//  Created by Evan Gan on 3/1/25.
//

import Cocoa

class AppTracker {
    private var lastApp: String? = nil
    private var startTime: Date? = nil
    private var timer: Timer?

    init() {
        startTracking()
    }

    func startTracking() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.checkActiveApp()
        }
    }

    private func checkActiveApp() {
        if let activeApp = NSWorkspace.shared.frontmostApplication?.localizedName {
            if activeApp != lastApp {
                lastApp = activeApp
                startTime = Date()  // Reset timer when app changes
                print("Switched to: \(activeApp)")
            } else if let start = startTime {
                let elapsed = Date().timeIntervalSince(start)
                if elapsed >= 60 {  // Example: 60 seconds
                    self.showPopup(for: activeApp)
                }
            }
        }
    }

    private func showPopup(for app: String) {
        let alert = NSAlert()
        alert.messageText = "You've been using \(app) for too long!"
        alert.runModal()
    }
}

// Start tracking
let tracker = AppTracker()
RunLoop.main.run()  // Keeps script running
