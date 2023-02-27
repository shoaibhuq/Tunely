//
//  TrackCell.swift
//  lab-tunley
//
//  Created by Shoaib Huq on 2/25/23.
//

import UIKit
import Nuke

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Configures the cell's UI for the given track.
    func configure(with track: Track) {
        trackNameLabel.text = track.trackName
        artistNameLabel.text = track.artistName

        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: track.artworkUrl100, into: trackImageView)
    }

}
