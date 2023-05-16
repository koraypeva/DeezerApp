//
//  AlbumAdiveSarkiCollectionViewCell.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import UIKit

let d = UserDefaults.standard

class AlbumAdiveSarkiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var begenButton: UIButton!
    
    @IBOutlet weak var sarkiGorseli: UIImageView!
    
    @IBOutlet weak var sarkiSaniye: UILabel!
    
    
    @IBAction func begeniButton(_ sender: Any) {
        if begenButton.tag == 0 {
            begenButton.setImage(UIImage(named: "suit.heart.fill"), for: .normal)
            begenButton.tag = 1
        // idenfitier:    albumDetayToBegenilenler
         
        }
        else {
            begenButton.setImage(UIImage(named: "suit.heart"), for: .normal)
            begenButton.tag = 0
        }
      
        
    }
    
    
    
    @IBOutlet weak var sarkiAdiLabel: UILabel!
    
}
