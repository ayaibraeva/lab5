//
//  trackViewController.swift
//  MusicDownloader
//
//  Created by Ayaulym Ibrayeva on 4/28/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class trackViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tracks: [Track] = []
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            MusicService.shared.searchForMusic { [weak self] result, error in
                guard let self = self else { return }
                
                if let tracks = result?.tracks {
                    self.tracks = tracks
                    self.tableView.reloadData()
                } else if let error = error {
                    print(error)
                }
            }
        }


    }

    extension trackViewController: TrackTableViewCellDelegate {
        func didPressPlay(track: Track) {
            MusicService.shared.play(track: track)
        }
        
        func didPressDownload(track: Track, completion: @escaping (Track) -> ()) {
            MusicService.shared.download(track: track) { url, error in
                if let url = url {
                    
                    completion(track)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }

    extension trackViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.tracks.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath) as! TrackTableViewCell
            cell.track = self.tracks[indexPath.row]
            cell.delegate = self
            
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetail", sender: self)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? PlayerViewController {
                destination.track = tracks[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }


