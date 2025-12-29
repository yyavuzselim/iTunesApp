import Foundation
import Alamofire


final class APIService {

    static let shared = APIService()
    private init() {}

    func testSearch() {

        let url = "https://itunes.apple.com/search"

        let parameters: Parameters = ["term": "jack johnson"]
       

        AF.request(url, parameters: parameters).responseData { response in

                print("REQUEST URL:")
                print(response.request?.url?.absoluteString ?? "no url")

                switch response.result {
                case .success(let data):

                    do {
                        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
                        let items = self.mapToSearchItems(decoded.results)

                    } catch {
                        print("DECODE ERROR:", error)
                    }
                case .failure(let error):
                    print("ERROR:")
                    print(error)
                }
            }
    }
    
    private func formatDate(_ isoDate: String?) -> String {
        guard let isoDate = isoDate else { return "-" }

        let inputFormatter = ISO8601DateFormatter()

        guard let date = inputFormatter.date(from: isoDate) else {
            return "-"
        }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy"
        outputFormatter.locale = Locale(identifier: "en_US")

        return outputFormatter.string(from: date)
    }

    
    
    
    func mapToSearchItems(_ results: [SearchResult]) -> [SearchItem] {
        return results.compactMap { result in

            let title = result.trackName ?? result.collectionName
            guard let finalTitle = title else {
                return nil
            }

            let price = result.trackPrice ?? result.collectionPrice
            let priceText = price != nil ? "$\(price!)" : "Free"
            let releaseDateText = formatDate(result.releaseDate)

            return SearchItem(title: finalTitle,priceText: priceText,imageURL: result.artworkUrl100,releaseDateText: releaseDateText
            )
        }
    }


    
    func search(term: String, mediaType: MediaType, completion: @escaping ([SearchItem]) -> Void) {

        let url = "https://itunes.apple.com/search"
        let parameters: Parameters = ["term": term,"media": mediaType.media,"entity": mediaType.entity,"limit": 20]

        AF.request(url, parameters: parameters).responseData { response in
           
            if let data = response.data{
                print("Successful response with raw data")

            }
                  
                switch response.result {
                case .success(let data):
                    do {
                        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
                        let items = self.mapToSearchItems(decoded.results)
                        completion(items)
                    } catch {
                        print("DECODE ERROR:", error)
                        completion([])
                    }

                case .failure(let error):
                    print("API ERROR:", error)
                    completion([])
                }
            }

        }
    }



    



