import Foundation


class VideoListViewModel {
    var videos: [VideoInfo] = []
    
    func fetchVideos(completion: @escaping () -> Void) {
        // JSON Dummy API를 호출하여 데이터
        // 데이터를 가져온 후에는 videos 배열에 할당하고 completion을 호출
        guard let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json") else { return }
        // URLSession 데이터 요청
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Data task error: \(error)")
                return
            }
            
            guard let data = data else { return }
            do {
                // JSON 데이터를 Video 객체 배열로 변환
                self.videos = try JSONDecoder().decode([VideoInfo].self, from: data)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("JSON decode error: \(error)")
            }
        }
        task.resume()
    }
}
