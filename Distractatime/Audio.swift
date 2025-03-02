//
//  Audio.swift
//  Distractatime
//
//  Created by Evan Gan on 3/2/25.
//

import AVFoundation

var audioPlayer: AVPlayer?

func playAudio(from url: String) {
    guard let audioURL = URL(string: url) else {
        print("Invalid URL")
        return
    }

    audioPlayer = AVPlayer(url: audioURL)
    audioPlayer?.play()
}
