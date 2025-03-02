import Cocoa

class BouncingWindow: NSWindow {
    var dx: CGFloat = CGFloat.random(in: 2...5) * (Bool.random() ? 1 : -1)
    var dy: CGFloat = CGFloat.random(in: 2...5) * (Bool.random() ? 1 : -1)
    var timer: Timer?

    init() {
        let screenFrame = NSScreen.main?.frame ?? .zero
        let windowSize: CGFloat = 200
        let randomX = CGFloat.random(in: 0...(screenFrame.width - windowSize))
        let randomY = CGFloat.random(in: 0...(screenFrame.height - windowSize))

        super.init(
            contentRect: NSRect(x: randomX, y: randomY, width: windowSize, height: windowSize),
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )

        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .floating
        self.makeKeyAndOrderFront(nil)

        let textLabel = NSTextField(labelWithString: "Too productive!")
        textLabel.font = NSFont.systemFont(ofSize: 20, weight: .bold)
        textLabel.textColor = .red
        textLabel.alignment = .center
        textLabel.frame = NSRect(x: 0, y: 80, width: windowSize, height: 40)

        let contentView = NSView(frame: self.frame)
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.white.cgColor
        contentView.addSubview(textLabel)

        self.contentView = contentView
        startBouncing()
//        scheduleSelfDestruction()
    }

    func startBouncing() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.updatePosition()
        }
    }

    func scheduleSelfDestruction() {
        let destructionTime = 3.0 + Double.random(in: 0...5)
        Timer.scheduledTimer(withTimeInterval: destructionTime, repeats: false) { [weak self] _ in
            self?.close() // Safe call on weak self
        }
    }

    override func close() {
        timer?.invalidate() // Ensure timer stops before deallocating
        timer = nil
        super.close()
    }

    func updatePosition() {
        guard let screenFrame = NSScreen.main?.frame else { return }
        var newFrame = self.frame

        newFrame.origin.x += dx
        newFrame.origin.y += dy

        if newFrame.maxX >= screenFrame.maxX || newFrame.minX <= screenFrame.minX {
            dx *= -1
        }
        if newFrame.maxY >= screenFrame.maxY || newFrame.minY <= screenFrame.minY {
            dy *= -1
        }

        self.setFrame(newFrame, display: true)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var windowSpawnTimer: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        spawnWindow()

        windowSpawnTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.spawnWindow() // Ensure safe access
        }
    }

    func spawnWindow() {
        _ = BouncingWindow()
    }
}
