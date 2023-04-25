//
//  AlbumViewController.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/25.
//

import UIKit

class AlbumViewController: UIViewController {

//    private var viewModels = [AlbumCollectionViewCellViewModel]()
//
//    private var tracks = [AudioTrack]()

    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = album.name
        view.backgroundColor = .systemBackground
        APICaller.shared.getAlbumDetails(for: album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    break
                }
            }
        }
//        view.addSubview(collectionView)
//        collectionView.register(
//            AlbumTrackCollectionViewCell.self,
//            forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier
//        )
//        collectionView.register(
//            PlaylistHeaderCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier
//        )
    }
    
    
    
    

}
