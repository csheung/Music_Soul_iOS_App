//
//  APICaller.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import Foundation


/*
 xinyue
 */

final class APICaller {
    static let shared = APICaller()

    private init() {}

    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }

    enum APIError: Error {
        case faileedToGetData
    }
    
    
    // MARK: - Browse

    public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?country=KR"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }

                do {
                    //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    //print(result)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    

    public func getFeaturedFlaylists(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>) -> Void)) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?country=KR"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.faileedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
                    completion(.success(result))
                    //print(result)
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }


    
    // MARK: - Private

    enum HTTPMethod: String {
        case GET
        case PUT
        case POST
        case DELETE
    }

    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }

}
