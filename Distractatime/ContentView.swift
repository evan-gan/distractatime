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
                       openSlack()
                    },
                    20: {
                        showVideoWindow()
                    },
                    30: {
                        playAudio(from: "https://hc-cdn.hel1.your-objectstorage.com/s/v3/f1da3eaf61f873d416961b771b96012c5a10a9ea_siren_meme__sound_effect_-_3secvids__youtube__yrv667_7xiu__audio.mp4")
                    },
                    40: {
                        windowManager.startSpawningWindows()
                    }
                ]
            ])
            

        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
