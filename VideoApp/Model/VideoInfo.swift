import Foundation


struct VideoInfo: Codable {
    var id: String
    var title: String
    var thumbnailUrl: URL
    var videoUrl: URL
    var description: String
}
