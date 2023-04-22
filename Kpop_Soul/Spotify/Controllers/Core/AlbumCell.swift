//
//  AlbumCell.swift
//  Spotify
//
//  Created by Derrick Ng on 4/21/23.
//

import UIKit
import Nuke

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
//    func fetchAlbumData(albumIds: [String], accessToken: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        let ids = albumIds.joined(separator: ",")
//        let urlString = "https://api.spotify.com/v1/albums?ids=\(ids)"
//        
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//            } else if let data = data {
//                completion(.success(data))
//            } else {
//                completion(.failure(NSError(domain: "Unknown Error", code: -1, userInfo: nil)))
//            }
//            
//            do {
//                // Create a JSON Decoder
//                let decoder = JSONDecoder()
//                // Try to parse the response into our custom model
//                let response = try decoder.decode(AlbumSearchResponse.self, from: data)
//                let albums = response.albums
//                DispatchQueue.main.async {
//                    self?.albums = albums
//                    self?.collectionView.reloadData()
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }

    func configure(with album: Album) {
        
        if let imageUrl = album.images.first?.url {
            // Load image async via Nuke library image loading helper method
            Nuke.loadImage(with: imageUrl, into: albumImageView)
        } else {
            // Set image view to a placeholder image or nil
            albumImageView.image = UIImage(named: "albumImageView")
        }
    }
}

