
import AVKit
import SwiftUI

struct ContentView: View {
    
    @State private var player: AVPlayer
    
    
    @State private var isMuted = true
    @State var playerSize: CGSize = .init(width: 340, height: 200)
    private let videoDuration: TimeInterval = 100
    
    init(videoUrl: URL) {
        self.player = AVPlayer(url: videoUrl)
    }
    
    var body: some View {
        VideoPlayerView(player: player)
            .onAppear {
                playVideo()
            }
            .onDisappear {
                stopVideo()
            }
            .frame(width: playerSize.width, height: playerSize.height)
            .overlay {
                Rectangle()
                    .cornerRadius(8)
                    .overlay {
                        timeAndSoundControls
                    }
            }
    }
}

private extension ContentView {
    @ViewBuilder
    var timeAndSoundControls: some View {
        ZStack {
            durationLabel
                        
            soundControlButton
        }
        .padding(.top, -90)
    }
    
    @ViewBuilder
    var durationLabel: some View {
        Text(formattedVideoDuration())
            .foregroundStyle(.white)
            .font(.system(size: 11))
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 33, height: 16)
                    .foregroundStyle(.black)
                    .opacity(0.8))
            .offset(x: -140)
    }
    
    @ViewBuilder
    var soundControlButton: some View {
        Button {
            switch isMuted {
            case true:
                player.isMuted = false
            case false:
                player.isMuted = true
            }
            isMuted.toggle()
        } label: {
            Image(isMuted ? "soundOff" : "soundOn")
        }
        .offset(x: 140)
    }
    
    func playVideo() {
        DispatchQueue.main.async {
            player.play()
            player.isMuted = true
        }
    }
    
    func stopVideo() {
        DispatchQueue.main.async {
            player.pause()
        }
    }
    
    func formattedVideoDuration() -> String {
        let minute = Int(videoDuration) / 60
        let seconds = Int(videoDuration) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

private struct VideoPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let vc = AVPlayerViewController()
        vc.player = player
        vc.showsPlaybackControls = false
        return vc
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {   }
    
}

#Preview {
    ContentView(videoUrl: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
}
