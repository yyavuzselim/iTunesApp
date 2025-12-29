import Foundation

struct SearchResponse: Codable  {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let collectionName: String?
    let trackName: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let artworkUrl100: String?
    let releaseDate: String?
}


struct SearchItem {
    let title: String
    let priceText: String
    let imageURL: String? 
    let releaseDateText: String
}



enum MediaType {
    case movie
    case music
    case ebook
    case podcast

    var media: String {
        switch self {
        case .movie: return "movie"
        case .music: return "music"
        case .ebook: return "ebook"
        case .podcast: return "podcast"
        }
    }

    var entity: String {  
        switch self {
        case .movie: return "tvEpisode"
        case .music: return "musicTrack"
        case .ebook: return "ebook"
        case .podcast: return "podcast"
        }
    }
}
