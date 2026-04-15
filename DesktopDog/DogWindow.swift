//
//  DogWindow.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import Cocoa

class DogWindow: NSWindow {

    init() {
        let screen = NSScreen.main!.frame

        super.init(
            contentRect: NSRect(x: 100, y: 100, width: 120, height: 120),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        self.level = .floating
        self.backgroundColor = .clear
        self.isOpaque = false
        self.hasShadow = false
        self.ignoresMouseEvents = true
        self.level = .screenSaver
        self.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary
        ]
    }
}
