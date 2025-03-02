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
    @State private var lastActiveTime: Date? = Date() // Ensures tracking starts immediately
    @State private var appUsage: [String: TimeInterval] = [:]  // Dictionary to track usage
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let distractions: [String:[Int: () -> ()]]

    init(distractions: [String:[Int: () -> ()]]) {
        self.distractions = distractions
    }
    
    var body: some View {
        VStack {
            Text("Active Apps Usage")
                .font(.headline)
                .padding(.bottom, 5)

            List(sortedAppUsage(), id: \.0) { app, time in
                HStack {
                    Text(app)
                        .fontWeight(.bold)
                    Spacer()
                    Text(formattedTime(time))
                        .foregroundColor(.gray)
                }
            }
        }
        .onReceive(timer) { _ in
            updateActiveApp()
        }
    }

    private func updateActiveApp() {
        let now = Date()
        if let activeApp = NSWorkspace.shared.frontmostApplication?.localizedName {
                // Store previous app time before switching
                if let lastTime = lastActiveTime {
                    let elapsed = now.timeIntervalSince(lastTime)
                    appUsage[currentApp, default: 0] += elapsed
                    if (currentApp == "Distractatime") {
                        appUsage["Xcode", default: 0] += elapsed
                    }
                }

                // Update current app and start tracking
                currentApp = activeApp
                lastActiveTime = now
            
            let lambdaCallFrequency: Int = 3
            
            for distractionApp in distractions.keys {
                if let distractionTime = distractions[distractionApp] {
                    for (duration, lambda) in distractionTime where (Int(duration) <= Int(appUsage[currentApp] ?? 0)) {
                        if ((Int(appUsage[currentApp] ?? 0) % lambdaCallFrequency) == 0) {
                            lambda()
                        }
                    }
                }
            }
        }
    }

    private func sortedAppUsage() -> [(String, TimeInterval)] {
        return appUsage.sorted { $0.value > $1.value }  // Sort by most used
    }

    private func formattedTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
