//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Derrick Ng on 4/21/23.
//

import UIKit
import Nuke

class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var albums: [Album] = []

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var introLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Tells the collection view how many items to display.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // the number of items shown should be the number of albums we have.
            albums.count
    }
    
    // Creates, configures and returns the cell to display for a given index path.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a collection view cell (based in the identifier you set in storyboard) and cast it to our custom AlbumCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell

        // Use the indexPath.item to index into the albums array to get the corresponding album
        let album = albums[indexPath.item]

        // Get the artwork image url
        let imageUrl = album.images.first?.url

        // Set the image on the image view of the cell
        if let imageUrl = imageUrl {
            Nuke.loadImage(with: imageUrl, into: cell.albumImageView)
        }

        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a search URL for fetching albums (`entity=album`)
        let url = URL(string: "https://itunes.apple.com/search?term=blackpink&attribute=artistTerm&entity=album&media=music")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            do {
                // Create a JSON Decoder
                let decoder = JSONDecoder()
                // Try to parse the response into our custom model
                let response = try decoder.decode(AlbumSearchResponse.self, from: data)
                let albums = response.albums
                DispatchQueue.main.async {
                    self?.albums = albums
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }

        // Initiate the network request
        task.resume()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Get a reference to the collection view's layout
        // Dynamically size the cells for the available space and desired number of columns.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        layout.minimumInteritemSpacing = 4

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)
    }

}
