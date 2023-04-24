//
//  ViewController.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import UIKit

enum BrowseSectionType {
    case newReleases//(viewModels: [NewReleasesCellViewModel]) // 1
    case featuredPlaylists//(viewModels: [FeaturedPlaylistCellViewModel]) // 2
    
    
    var title: String {
        switch self {
        case .newReleases:
            return "Latest KPOP Albums"
        case .featuredPlaylists:
            return "KPOP Featured Playlists"
            
        }
    }
}
    
    class HomeViewController: UIViewController {
        
        private var collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
                return HomeViewController.createSectionLayout(section: sectionIndex)
            }
        )
        
        private let spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView()
            spinner.tintColor = .label
            spinner.hidesWhenStopped = true
            return spinner
        }()
        
        //private var sections = [BrowseSectionType]()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            title = "Browse"
            view.backgroundColor = .systemBackground
            
            
            configureCollectionView()
            view.addSubview(spinner)
            fetchData()
            //addLongTapGesture()
        }
        
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            collectionView.frame = view.bounds
        }
        
        private func configureCollectionView() {
            view.addSubview(collectionView)
            collectionView.register(UICollectionViewCell.self,
                                    forCellWithReuseIdentifier: "cell")
            //        collectionView.register(NewReleaseCollectionViewCell.self,
            //                                forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
            //        collectionView.register(FeaturedPlaylistCollectionViewCell.self,
            //                                forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
            //        collectionView.register(RecommendedTrackCollectionViewCell.self,
            //                                forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
            //        collectionView.register(
            //            TitleHeaderCollectionReusableView.self,
            //            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            //            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier
            //        )
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundColor = .systemBackground
        }
        
        
        
        
        
        // The real function for creating layout
        private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
            //        let supplementaryViews = [
            //            NSCollectionLayoutBoundarySupplementaryItem(
            //                layoutSize: NSCollectionLayoutSize(
            //                    widthDimension: .fractionalWidth(1),
            //                    heightDimension: .absolute(50)
            //                ),
            //                elementKind: UICollectionView.elementKindSectionHeader,
            //                alignment: .top
            //            )
            //        ]
            //
            switch section {
            case 0:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                // Vertical group inside a horizontal group
                let verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(390)//390
                    ),
                    subitem: item,
                    count: 3
                )
                
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .absolute(390)
                    ),
                    subitem: verticalGroup,
                    count: 1
                )
                
                // Section
                let section = NSCollectionLayoutSection(group: horizontalGroup) //horizontal group
                section.orthogonalScrollingBehavior = .continuous
                return section
                //            section.orthogonalScrollingBehavior = .groupPaging
                //            section.boundarySupplementaryItems = supplementaryViews
                //            return section
            case 1:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(200)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(400)
                    ),
                    subitem: item,
                    count: 2
                )
                
                //scroll horizontally
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(200),
                        heightDimension: .absolute(400)
                    ),
                    subitem: verticalGroup,
                    count: 1
                )
                
                // Section
                let section = NSCollectionLayoutSection(group: horizontalGroup)
                section.orthogonalScrollingBehavior = .continuous
                //section.boundarySupplementaryItems = supplementaryViews
                return section
                
            default:
                // Item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(390)
                    ),
                    subitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                //  section.boundarySupplementaryItems = supplementaryViews
                return section
                
            }
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
    
    extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
            //        let type = sections[section]
            //        switch type {
            //        case .newReleases(let viewModels):
            //            return viewModels.count
            //        case .featuredPlaylists(let viewModels):
            //            return viewModels.count
            //        case .recommendedTracks(let viewModels):
            //            return viewModels.count
            //        }
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2//sections.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if indexPath.section == 0 {
                cell.backgroundColor = .systemGreen
            } else if indexPath.section == 1 {
                cell.backgroundColor = .systemRed
            }
            return cell
        }
    }
    
    

