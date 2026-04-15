//
//  DogView.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import SwiftUI
import Combine

struct DogView: View {

    @ObservedObject var dogState: DogStateModel
    @State private var frame = 0

    private let walkingFrames = ["dog1", "dog2", "dog3", "dog4"]
    private let animationTimer = Timer.publish(every: 0.18, on: .main, in: .common).autoconnect()

    var body: some View {
        Image(currentImageName)
            .resizable()
            .frame(width: 120, height: 120)
            .scaleEffect(x: dogState.isFacingLeft ? -1 : 1, y: 1)
            .onReceive(animationTimer) { _ in
                if isWalking {
                    frame = (frame + 1) % walkingFrames.count
                } else {
                    frame = 0
                }
            }
    }

    private var currentImageName: String {
        switch dogState.activity {
        case .walkingLeft, .walkingRight:
            return walkingFrames[frame]
        case .idle:
            return "dog_idle"
        case .sleeping:
            return "dog_sleep"
        }
    }

    private var isWalking: Bool {
        switch dogState.activity {
        case .walkingLeft, .walkingRight:
            return true
        case .idle, .sleeping:
            return false
        }
    }
}
