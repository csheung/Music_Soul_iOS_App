//
//  ViewController.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Browse"
        view.backgroundColor = .systemBackground
        
        
//        configureCollectionView()
//        view.addSubview(spinner)
        fetchData()
        //addLongTapGesture()
    }

    
    private func fetchData() {
//        let group = DispatchGroup()
//        group.enter()
//        group.enter()
//        group.enter()
//        var newReleases: NewReleasesResponse?
//        var featuredPlaylist: FeaturedPlaylistsResponse?
//        var recommendations: RecommendationsResponse?

        // New Releases
        APICaller.shared.getFeaturedFlaylists { _ in
//            defer {
//                group.leave()
//            }
//            switch result {
//            case .success(let model):break
////                newReleases = model
//            case .failure(let error):break
                //print(error.localizedDescription)
            }
        }

//        // Featured Playlists
//        APICaller.shared.getFeaturedFlaylists { result in
//            defer {
//                group.leave()
//            }
//
//            switch result {
//            case .success(let model):
//                featuredPlaylist = model
//            case .failure(let error):
//                print(error.localizedDescription)
//
//            }
//        }
//
//        // Recommended Tracks
//        APICaller.shared.gerRecommendedGenres { result in
//            switch result {
//            case .success(let model):
//                let genres = model.genres
//                var seeds = Set<String>()
//                while seeds.count < 5 {
//                    if let random = genres.randomElement() {
//                        seeds.insert(random)
//                    }
//                }
//
//                APICaller.shared.getRecommendations(genres: seeds) { recommendedResult in
//                    defer {
//                        group.leave()
//                    }
//
//                    switch recommendedResult {
//                    case .success(let model):
//                        recommendations = model
//
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        group.notify(queue: .main) {
//            guard let newAlbums = newReleases?.albums.items,
//                  let playlists = featuredPlaylist?.playlists.items,
//                  let tracks = recommendations?.tracks else {
//                fatalError("Models are nil")
//            }
//            self.configureModels(
//                newAlbums: newAlbums,
//                playlists: playlists,
//                tracks: tracks
//            )
//        }
    
}

