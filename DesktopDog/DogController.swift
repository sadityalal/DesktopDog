//
//  MouseTracker.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import Cocoa
import Combine

enum DogActivity {
    case idle
    case sleeping
    case walkingLeft
    case walkingRight
}

final class DogStateModel: ObservableObject {
    @Published var activity: DogActivity = .idle
    @Published var isFacingLeft = false
}

final class DogController {

    var window: NSWindow
    let dogState: DogStateModel
    var speed: CGFloat = 0.8
    let groundY: CGFloat = 40
    private var nextBehaviorChange = Date()
    private var positionX: CGFloat

    init(window: NSWindow, dogState: DogStateModel) {
        self.window = window
        self.dogState = dogState
        self.positionX = window.frame.origin.x
        chooseNextBehavior()

        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            self.update()
        }
    }

    func update() {
        var frame = window.frame
        guard let bounds = horizontalBounds(for: frame) else {
            return
        }

        frame.origin.y = groundY

        if Date() >= nextBehaviorChange {
            chooseNextBehavior()
        }

        switch dogState.activity {
        case .walkingLeft:
            positionX -= speed
            if positionX <= bounds.lowerBound {
                positionX = bounds.lowerBound
                frame.origin.x = positionX
                window.setFrame(frame, display: true)
                chooseNextBehavior()
                return
            }
        case .walkingRight:
            positionX += speed
            if positionX >= bounds.upperBound {
                positionX = bounds.upperBound
                frame.origin.x = positionX
                window.setFrame(frame, display: true)
                chooseNextBehavior()
                return
            }
        case .idle, .sleeping:
            break
        }

        positionX = min(max(positionX, bounds.lowerBound), bounds.upperBound)
        frame.origin.x = positionX
        window.setFrame(frame, display: true)
    }

    private func chooseNextBehavior() {
        let options = availableBehaviors()
        let nextActivity = options.randomElement() ?? .idle
        dogState.activity = nextActivity

        switch nextActivity {
        case .walkingLeft:
            dogState.isFacingLeft = true
            nextBehaviorChange = Date().addingTimeInterval(Double.random(in: 1.5...4.0))
        case .walkingRight:
            dogState.isFacingLeft = false
            nextBehaviorChange = Date().addingTimeInterval(Double.random(in: 1.5...4.0))
        case .idle:
            nextBehaviorChange = Date().addingTimeInterval(Double.random(in: 1.0...3.0))
        case .sleeping:
            nextBehaviorChange = Date().addingTimeInterval(Double.random(in: 2.5...5.0))
        }
    }

    private func availableBehaviors() -> [DogActivity] {
        var options: [DogActivity] = [.idle, .sleeping]
        let frame = window.frame

        if let bounds = horizontalBounds(for: frame) {
            if positionX > bounds.lowerBound + 1 {
                options.append(.walkingLeft)
            }

            if positionX < bounds.upperBound - 1 {
                options.append(.walkingRight)
            }
        } else {
            options.append(contentsOf: [.walkingLeft, .walkingRight])
        }

        return options
    }

    private func horizontalBounds(for frame: NSRect) -> ClosedRange<CGFloat>? {
        if let screenFrame = window.screen?.visibleFrame ?? NSScreen.main?.visibleFrame {
            return screenFrame.minX...(screenFrame.maxX - frame.width)
        }

        return nil
    }
}
