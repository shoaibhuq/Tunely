//
//  AlbumsViewController.swift
//  lab-tunley
//
//  Created by Shoaib Huq on 3/7/23.
//

import UIKit
import Nuke

class AlbumsViewController: UIViewController {
    
    
    
    var albums: [Album] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        
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
            
            let decoder = JSONDecoder()
            do {
                // Try to parse the response into our custom model
                let response = try decoder.decode(AlbumSearchResponse.self, from: data)
                let albums = response.results
                
                self?.albums = albums
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // Initiate the network request
        task.resume()
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 4
        
        layout.minimumLineSpacing = 4
        
        let numberOfColumns: CGFloat = 3
        
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    
}

extension AlbumsViewController: UICollectionViewDataSource {
    
    // Tells the collection view how many items to display.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
        
    }
    
    // Creates, configures and returns the cell to display for a given index path.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        let album = albums[indexPath.item]
        
        let imageUrl = album.artworkUrl100
        
        Nuke.loadImage(with: imageUrl, into: cell.albumImageView)
        
        return cell
        
    }
    
}
