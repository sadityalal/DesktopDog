//
//  DesktopDogApp.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import SwiftUI

@main
struct DesktopDogApp: App {

    let window: DogWindow
    let dogState: DogStateModel
    let dogController: DogController

    init() {
        let dogState = DogStateModel()
        let window = DogWindow()
        let dogController = DogController(window: window, dogState: dogState)

        window.contentView = NSHostingView(rootView: DogView(dogState: dogState))
        window.makeKeyAndOrderFront(nil)

        self.window = window
        self.dogState = dogState
        self.dogController = dogController
    }

    var body: some Scene {
        Settings { EmptyView() }
    }
}
