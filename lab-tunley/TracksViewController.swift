//
//  ViewController.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/1/22.
//

import UIKit

class TracksViewController: UIViewController, UITableViewDataSource {
    
    

    // TODO: Pt 1 - Add a tracks property
    
    var tracks: [Track] = []

    // TODO: Pt 1 - Add table view outlet

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracks = Track.mockTracks
        
        tableView.dataSource = self
//      tableView.delegate = self
                
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Pt 1 - Pass the selected track to the detail view controller
        
        guard let cell = sender as? UITableViewCell else{
            print("ERROR:: invalid cell data")
            return
        }
        
        let indexPath = tableView.indexPath(for: cell)
        let track = tracks[indexPath?.row ?? 0]
        
        let destVC = segue.destination as? DetailViewController
        
        destVC?.track = track
        

    }

    // TODO: Pt 1 - Add table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell with identifier, "TrackCell"
        // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell

        // Get the track that corresponds to the table view row
        let track = tracks[indexPath.row]

        // Configure the cell with it's associated track
        
        cell.configure(with: track)

        // return the cell for display in the table view
        return cell
    }
    

}
