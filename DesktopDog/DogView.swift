//
//  DogView.swift
//  DesktopDog
//
//  Created by Aditya Saurabh on 15.04.26.
//

import SwiftUI

struct DogView: View {

    @State var frame = 0

    let frames = ["dog1", "dog2", "dog3", "dog4", "dog_idle", "dog_sleep"]

    var body: some View {
        Image(frames[frame])
            .resizable()
            .frame(width: 120, height: 120)
            .onAppear {

                Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { _ in
                    frame = (frame + 1) % frames.count
                }
            }
    }
}
