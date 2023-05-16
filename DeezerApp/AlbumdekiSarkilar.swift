//
//  AlbumdekiSarkilar.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import Foundation

class albumdekiSarkilar:Codable {
    
    
    var kategoriler:Category?
    var albumSarkiAdi:String?
    var albumResimAdi:String?
    var albumSarkisaniye:String?
    
    //ilgili api:  https://api.deezer.com/album/album_id
    
    init() {
        
    }
    init(kategoriler:Category,albumSarkiAdi:String,albumResimAdi:String,albumSarkisaniye:String) {
    
        self.kategoriler = kategoriler
        self.albumSarkiAdi = albumSarkiAdi
        self.albumResimAdi = albumResimAdi
        self.albumSarkisaniye = albumSarkisaniye
        
    }
}
