import Foundation


class VideoListViewModel {
    var videos: [VideoInfo] = []
    
    func fetchVideos(completion: @escaping () -> Void) {
        
        guard let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json") else {
            completion()
            return
        }
        // URLSession 데이터 요청
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion()
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion()
                }
                return
            }
            
            do {
                // JSON 데이터를 Video 객체 배열로 변환
                self.videos = try JSONDecoder().decode([VideoInfo].self, from: data)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
        task.resume()
    }
}
