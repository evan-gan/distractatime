import SwiftUI
import Cocoa

struct ContentView: View {
    @State private var showVideo = false
    private let windowManager = WindowManager()
    
    // State variables for random colors
    @State private var backgroundColor: Color = .white
    @State private var textColor: Color = .black
    
    // Function to generate random color
    func randomColor() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    
    var body: some View {
        VStack {
            // Using Comic Sans for the text
            ActiveAppTimerView(distractions: [
                "Visual Studio Code": [
                    5+10: {
                        updateFont(to: Font_Class.fonts[Font_Class.font_index % Font_Class.fonts.count])
                        print(Font_Class.fonts[Font_Class.font_index % Font_Class.fonts.count])
                        Font_Class.font_index += 1
                    },
                    10+10: {
                        openSlack()
                    },
                    20+10: {
                        OnceUponATime.run("Surfers", {showVideoWindow()})
                    },
                    30+10: {
                        playAudio(from: "https://hc-cdn.hel1.your-objectstorage.com/s/v3/f1da3eaf61f873d416961b771b96012c5a10a9ea_siren_meme__sound_effect_-_3secvids__youtube__yrv667_7xiu__audio.mp4")
                    },
                    40+10: {
                        windowManager.startSpawningWindows()
                        OnceUponATime.run("servo", {
                            let url = URL(string: "http://192.168.131.38:5000/on")!
                            
                            URLSession.shared.dataTask(with: url) { _, _, _ in
                                // Do nothing with the response
                            }.resume()
                        })
                    }
                ]
            ])
        }
        .padding()
        .background(backgroundColor)  // Apply random background color
        .foregroundColor(textColor)   // Apply random text color
        .onAppear {
            // Set random colors when the view appears
            backgroundColor = randomColor()
            textColor = randomColor()
        }
        .font(.custom("Comic Sans MS", size: 16))  // Set font to Comic Sans MS
    }
}
