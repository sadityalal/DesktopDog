//
//  DesktopDogApp.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import SwiftUI

@main
struct DesktopDogApp: App {

    var window: DogWindow!

    init() {
        window = DogWindow()
        window.contentView = NSHostingView(rootView: DogView())
        window.makeKeyAndOrderFront(nil)

        _ = DogController(window: window)
    }

    var body: some Scene {
        Settings { EmptyView() }
    }
}
