import UIKit

class VideoCell: UITableViewCell {
    var thumbnailImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func configure(with video: VideoInfo) {
        // 이미지 로드
        URLSession.shared.dataTask(with: video.thumbnailUrl) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: data)
                }
            }
        }.resume()
        titleLabel.text = video.title
    }
}
