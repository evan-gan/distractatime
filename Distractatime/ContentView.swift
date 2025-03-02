//
//  ContentView.swift
//  Distractatime
//
//  Created by Evan Gan on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showVideo = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            ActiveAppTimerView(distractions: [
                "Xcode": [  // For Xcode
                    10 : { doFraud("e") } // Wrap the function call in a closure
                ]
            ])

            Button("Play Fullscreen Video") {
                       showVideo = true
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
    
    private func doFraud(_ fraud: String) {
        print(fraud)
    }
}


#Preview {
    ContentView()
}
