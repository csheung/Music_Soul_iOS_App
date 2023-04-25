//
//  ArtistCell.swift
//  Spotify
//
//  Created by Xinyue Wang new mac on 4/18/23.
//

import UIKit
import Nuke

class ArtistCell: UITableViewCell {
    
    let artistImageView = UIImageView()
    let artistNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set up the artist image view
        artistImageView.contentMode = .scaleAspectFit
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artistImageView)
        
        // Set up the artist name label
        artistNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        artistNameLabel.numberOfLines = 0
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artistNameLabel)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            artistImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            artistImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            artistImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            artistImageView.widthAnchor.constraint(equalTo: artistImageView.heightAnchor),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            artistNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistImageView.image = nil
        artistNameLabel.text = nil
    }
    
    func configure(with artist: Artist) {
        artistNameLabel.text = artist.name
        
        if let imageUrl = artist.images.first?.url {
            // Load image async via Nuke library image loading helper method
            Nuke.loadImage(with: imageUrl, into: artistImageView)
        } else {
            // Set image view to a placeholder image or nil
            artistImageView.image = UIImage(named: "placeholderImage")
        }
    }
}
