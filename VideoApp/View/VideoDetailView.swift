import UIKit
import AVKit


class VideoDetailView: UIViewController {
    var viewModel: VideoDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    func playVideo() {
        guard let videoUrl = viewModel?.video?.videoUrl else { return }
        
        let player = AVPlayer(url: videoUrl)
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
        }
    }
}


