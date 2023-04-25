//
//  ViewController.swift
//  Spotify
//
//  Created by biubiubiu on 2023/4/11.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    var artists = [Artist](){
        didSet{
            tableView.reloadData()
        }
    }

   @IBOutlet weak var tableView: UITableView!
    // issue: table view: found nil while implicitly unwrapping an Optional value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        if let accessToken = UserDefaults.standard.string(forKey: "access_token") {
            
            // use the access token to make API calls
            fetchKpopArtists(accessToken: accessToken)
        } else {
            // access token not found, sign in again
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        }
    }
    
    
    
    func fetchKpopArtists(accessToken: String) {
        let urlString = "https://api.spotify.com/v1/search?q=kpop&type=artist&market=US"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)

        
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error fetching K-pop artists: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from Spotify API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SearchResponse.self, from: data)
                let artists = response.artists.items
                print("✅ \(artists)")
                DispatchQueue.main.async {
                    self?.artists = artists
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error decoding Spotify API response: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        tableView.dataSource=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // TODO: Deselect any selected table view rows

        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {

            // Deslect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Pt 1 - Pass the selected track to the detail view controller

        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = tableView.indexPath(for: cell),
           // Get the detail view controller
           let detailViewController = segue.destination as? DetailViewController {

            // Use the index path to get the associated track
            let artist = artists[indexPath.row]

            // Set the track on the detail view controller
            detailViewController.artist = artist
        }
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Get a cell with identifier, "TrackCell"
        // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistCell

        // Get the track that corresponds to the table view row
        let artist = artists[indexPath.row]

        // Configure the cell with it's associated track
        cell.configure(with: artist)

        // return the cell for display in the table view
        return cell
    }
}
