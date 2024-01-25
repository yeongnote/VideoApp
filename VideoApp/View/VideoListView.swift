import UIKit
import AVKit

class ViewListView: UIViewController {
    var viewModel: VideoListViewModel = VideoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchVideos {
            
        }
    }
}
