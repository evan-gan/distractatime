//
//  ContentView.swift
//  Distractatime
//
//  Created by Evan Gan on 3/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            // Add the active app timer component
            ActiveAppTimerView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
