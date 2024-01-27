import UIKit

class VideoCell: UITableViewCell {
    var thumbnailImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 4
        return label
    }()
    var dataTask: URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        autoLayouts()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VideoCell {
    func configure(with video: VideoInfo) {
        titleLabel.text = video.title
        descriptionLabel.text = video.description
        
        // 이미지 로드 작업 취소
        dataTask?.cancel()
        
        // 이미지 로드
        dataTask = URLSession.shared.dataTask(with: video.thumbnailUrl) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }
        dataTask?.resume()
    }
    
    // UITableViewCell 클래스에 정의되어 있는 메서드
    // 셀이 재사용되기 전에 호출
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel() //셀이 재사용되기 전에 이미지 로드 작업이 취소
        dataTask = nil //dataTask를 초기화하여 새로운 이미지 로드 작업을 준비
    }
}

extension VideoCell {
    func addSubViews() {
        self.contentView.addSubviews([
            titleLabel, descriptionLabel, thumbnailImageView
        ])
    }
    
    func autoLayouts() {
        // 레이아웃 설정
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(contentView).inset(10)
            make.width.equalTo(thumbnailImageView.snp.height).multipliedBy(16.0/9.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(contentView).inset(10)
        }
    }
}
