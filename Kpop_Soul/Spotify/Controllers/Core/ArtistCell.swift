//
//  ArtistCell.swift
//  Spotify
//
//  Created by Xinyue Wang new mac on 4/18/23.
//

import UIKit
import Nuke

class ArtistCell: UITableViewCell {
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
