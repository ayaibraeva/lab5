//
//  PlayerViewController.swift
//  MusicDownloader
//
//  Created by Ayaulym Ibrayeva on 4/28/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    var track: Track?
     
    @IBOutlet weak var namelbl: UILabel!
    @IBAction func playButton(_ sender: UIButton) {
        didPressPlay(track: (track!))
    }
    @IBAction func pauseButton(_ sender: UIButton) {
    }
    func didPressPlay(track: Track) {
        MusicService.shared.play(track: track)
    }
    override func viewDidLoad() {
        super .viewDidLoad()
        namelbl.text = track?.trackName
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
