//
//  ViewController.swift
//  MusicDownloader
//
//  Created by erumaru on 4/18/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var urls: [String] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
     
}
    override func viewDidAppear(_ animated: Bool) {
        
         navigationItem.leftBarButtonItem = .init(title: "Download Music", style: .plain, target: self, action: #selector(addMusic))
        navigationItem.rightBarButtonItem = .init(title: "Create Folder", style: .plain, target: self, action: #selector(createFolder))
        
    }
    
    @objc private func addMusic(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let trackViewController = storyBoard.instantiateViewController(withIdentifier: "trackVC") as! trackViewController
        self.present(trackViewController, animated:true, completion:nil)
        
    }
    @objc private func createFolder(){
        
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "track", for: indexPath) as!  TrackCollectionViewCell
        
        
        return cell
        
        
    }
    
    
}

