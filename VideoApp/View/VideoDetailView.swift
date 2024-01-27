import UIKit
import AVKit


class VideoDetailView: UIViewController {
    var viewModel: VideoDetailViewModel?
    var playVC = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        addPlayView()
    }
    func addPlayView() {
        addChild(playVC)
        view.addSubview(playVC.view)
        playVC.view.frame = view.frame
    }
    
    func playVideo() {
        guard let videoUrl = viewModel?.video?.videoUrl else { return }
        
        let player = AVPlayer(url: videoUrl)
        playVC.player = player
        player.play()
    }
}


