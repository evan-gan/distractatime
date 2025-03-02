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
//                        showVideo = true
                        showVideoWindow()
                    },
                    20: {
                        playAudio(from: "https://hc-cdn.hel1.your-objectstorage.com/s/v3/f1da3eaf61f873d416961b771b96012c5a10a9ea_siren_meme__sound_effect_-_3secvids__youtube__yrv667_7xiu__audio.mp4")
                    },
                    30: {
                        windowManager.startSpawningWindows()
                    }
                ]
            ])
            
//            Button("Don't click me. Seriously.") {
//                showVideo = true
//                windowManager.startSpawningWindows()
//            }
//            .font(.title)
//            .padding()
//            .sheet(isPresented: $showVideo) {
//                FullScreenVideoView(isPresented: $showVideo)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Color.black)
//            }
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

//#Preview {
//    ContentView()
//}
