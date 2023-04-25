//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import UIKit

class PlaylistViewController: UIViewController {
    private let playlist: Playlist

    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor = .systemBackground
        
        //        view.addSubview(collectionView)
        //        collectionView.register(
        //            RecommendedTrackCollectionViewCell.self,
        //            forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier
        //        )
        //        collectionView.register(
        //            PlaylistHeaderCollectionReusableView.self,
        //            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
        //            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier
        //        )
        //        collectionView.backgroundColor = .systemBackground
        //        collectionView.delegate = self
        //        collectionView.dataSource = self
        //
        APICaller.shared.getPlaylistDetails(for: playlist) {result in
            //            DispatchQueue.main.async {
            switch result {
            case .success(let model):
                break
                //                    self?.tracks = model.tracks.items.compactMap({ $0.track })
                //                    self?.viewModels = model.tracks.items.compactMap({
                //                        RecommendedTrackCellViewModel(
                //                            name: $0.track.name,
                //                            artistName: $0.track.artists.first?.name ?? "-",
                //                            artworkURL: URL(string: $0.track.album?.images.first?.url ?? "")
                //                        )
                //                    })
                //                    self?.collectionView.reloadData()
            case .failure(let error):
                break
                //print(error.localizedDescription)
            }
        }
    }


}
