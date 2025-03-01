import SwiftUI
import AVKit

struct FullScreenVideoView: View {
    @Binding var isPresented: Bool
    private let player = AVPlayer(url: URL(string: "https://hc-cdn.hel1.your-objectstorage.com/s/v3/67aea3f03f2a1cd370d2ca763347b3f231d374e5_subway_surfers__2024__-_gameplay__4k_16x9__no_copyright__i0m4are9v0y_.mp4")!) // Replace with your video URL

    var body: some View {
        ZStack {
            VideoPlayer(player: player)
                .frame(minWidth: 1000, minHeight: 800)
                .onAppear {
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
        }
    }
}

//struct ContentView: View {
//    @State private var showPopup = false
//
//    var body: some View {
//        ZStack {
//            Button("Show Video") {
//                showPopup = true
//            }
//            .font(.title)
//            .padding()
//        }
//        .fullScreenCover(isPresented: $showPopup) {
//            VideoPopupView(isPresented: $showPopup)
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
