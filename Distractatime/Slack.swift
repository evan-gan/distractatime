//
//  Slack.swift
//  Distractatime
//
//  Created by Sofia Egan on 3/2/25.
//

import AppKit

func openSlack() {
    if !Slack.openedConfessions {
        if ((NSApp.keyWindow != nil ? NSApp.keyWindow!.title : "") != "Slack") {
            NSWorkspace.shared.open(URL(string:"https://hackclub.slack.com/archives/CNMU9L92Q")!)
        }
        Slack.openedConfessions = true
    }
    else {
        let apps = NSWorkspace.shared.runningApplications
        for app in apps where app.localizedName == "Slack" {
            app.activate()
            return
        }
    }
}

class Slack {
    static var openedConfessions = false
}
