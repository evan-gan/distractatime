//
//  ContentView.swift
//  Distractatime
//
//  Created by Evan Gan on 3/1/25.
//

import SwiftUI
import Cocoa

struct ContentView: View {
    @State private var showVideo = false
    private let windowManager = WindowManager()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            ActiveAppTimerView(distractions: [
                "Xcode": [
                    10: {
                        showVideo = true
                        windowManager.startSpawningWindows()
                    }
                ]
            ])

            Button("Play Fullscreen Video") {
                showVideo = true
                windowManager.startSpawningWindows()
            }
            .font(.title)
            .padding()
            .sheet(isPresented: $showVideo) {
                FullScreenVideoView(isPresented: $showVideo)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
            }
        }
        .padding()
    }
}

// Manages multiple bouncing windows
class WindowManager {
    private var windowSpawnTimer: Timer?
    
    func startSpawningWindows() {
        spawnWindow()
        windowSpawnTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.spawnWindow()
        }
    }
    
    private func spawnWindow() {
        _ = BouncingWindow()
    }
}
