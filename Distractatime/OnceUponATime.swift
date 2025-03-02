//
//  OnceUponATime.swift
//  Distractatime
//
//  Created by Evan Gan on 3/2/25.
//

class OnceUponATime {
    static var onceUponATime: [String:Bool] = [:]
    
    static func run(_ name: String, _ lambda: () -> Void) {
        if onceUponATime[name] ?? false {
            return
        }
        onceUponATime[name] = true
        lambda()
    }
}
