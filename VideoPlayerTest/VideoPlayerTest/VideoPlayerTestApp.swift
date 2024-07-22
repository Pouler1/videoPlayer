//
//  VideoPlayerTestApp.swift
//  VideoPlayerTest
//
//  Created by Павел Ершов on 12.07.2024.
//

import SwiftUI
import AVFoundation

@main
struct VideoPlayerTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(videoUrl: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)}
    }
}
