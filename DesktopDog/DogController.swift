//
//  MouseTracker.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import Cocoa

enum DogState {
    case idle
    case walkingLeft
    case walkingRight
}

class DogController {

    var window: NSWindow
    var speed: CGFloat = 2
    var direction: CGFloat = 1
    let groundY: CGFloat = 40

    init(window: NSWindow) {
        self.window = window

        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            self.update()
        }
    }

    func update() {
        var frame = window.frame
        let screenWidth = NSScreen.main!.frame.width

        // continuous movement
        frame.origin.x += speed * direction

        // bounce at edges
        if frame.origin.x < 0 {
            direction = 1
        }

        if frame.origin.x > screenWidth - frame.width {
            direction = -1
        }

        frame.origin.y = groundY
        window.setFrameOrigin(frame.origin)
    }
}
