# Distractatime

For Scrapyard, we were prompted to make a useless project. What better than an anti productivity app to fulfill this objective. 

Using SwiftUI, we developed a MacOS application which tracks the amount of time you spend coding, and deploys various distractions to prevent you from being productive. 

If you try to code for an excessive amount of time, productivity countermeasures such as repeatedly changing the font in VSCode to fonts like Wingdings will be deployed. However, if the user continues to attempt to code, further distractions will be implemented, such as opening [#confessions](https://hackclub.slack.com/archives/CNMU9L92Q) (a channel on the Hack Club Slack notorious for being a distraction) and playing Subway Surfers with very loud volume. As a last resort, siren noises will play, annoying windows will spawn and move across the screen, with a loud balloon popping as a final deterrent.

<details closed>
<summary><b>How to reset the font in Visual Studio Code</b></summary>
<br>
Open VS Code and open the Command Palette. Open “Preferences: Open User Settings (JSON)”. Delete the font (with key "editor.fontFamily") in the JSON.
</details>
