//
//  Font.swift
//  Distractatime
//
//  Created by Sofia Egan on 3/2/25.
//

import Foundation

// Define the file path
let filePath = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent("Library/Application Support/Code/User/settings.json")
    .path

func loadJSON(from path: String) -> [String: Any]? {
    let expandedPath = (path as NSString).expandingTildeInPath
    
    guard FileManager.default.fileExists(atPath: expandedPath),
          let data = FileManager.default.contents(atPath: expandedPath) else {
        print("Failed to load JSON file at: \(expandedPath)")
        return nil
    }
    
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return json
    } catch {
        print("Error parsing JSON: \(error)")
        return nil
    }
}

// Save JSON back to file
func saveJSON(_ json: [String: Any], to path: String) {
    let expandedPath = (path as NSString).expandingTildeInPath

    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        try data.write(to: URL(fileURLWithPath: expandedPath))
        print("✅ JSON file updated successfully!")
    } catch {
        print("❌ Failed to save JSON: \(error)")
    }
}

// Update the font in the JSON file
func updateFont(to newFont: String) {
    if var json = loadJSON(from: filePath) {
        json["editor.fontFamily"] = newFont
        saveJSON(json, to: filePath)
    }
}

class Font_Class {
    static var fonts = [
        "Comic Sans MS",
        "Wingdings",
        "Papyrus",
        "Wingdings 2",
        "Impact",
        "Webdings",
        "Jokerman",
        "Symbol",
        "Curlz MT",
        "MS Gothic",
        "Chiller",
        "Dingbats",
        "Kristen ITC",
        "Marlett",
        "Giddyup",
        "Lucida Handwriting",
        "Marker Felt",
        "Brush Script MT"
      ]
    
    static var font_index = 0;
}
