import UIKit
import AVKit
import SnapKit

class VideoListView: UIViewController {
    var viewModel: VideoListViewModel = VideoListViewModel()
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        view.addSubview(tableView)
        self.view.backgroundColor = .white
        autoLayouts()
        
        viewModel.fetchVideos { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension VideoListView: UITableViewDelegate, UITableViewDataSource {
    // MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell else {
            return UITableViewCell()
        }
        let video = viewModel.videos[indexPath.row]
        cell.configure(with: video)
        
        
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = viewModel.videos[indexPath.row]
        let detailViewModel = VideoDetailViewModel(video: video)
        let detailView = VideoDetailView()
        detailView.viewModel = detailViewModel
        detailView.modalPresentationStyle = .pageSheet
        self.present(detailView, animated: true, completion: nil)
    }
    
}

extension VideoListView {
    func autoLayouts() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

#Preview {
    VideoListView()
}


