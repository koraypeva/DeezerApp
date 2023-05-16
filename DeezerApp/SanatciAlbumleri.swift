//
//  SanatciAlbumleri.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import Foundation

class sanatciAlbumleri:Codable {
    
    var kategoriler:Category?
    var sanatciAlbumAdi:String?
    var sanatciResimAdi:String?
    var cikisTarihi:String?
    
    // İlgili api: https://api.deezer.com/artist/artist_id
    
    init() {
        
    }
    init(kategoriler:Category,sanatciAlbumAdi:String,sanatciResimAdi:String,cikisTarihi:String) {
        self.kategoriler = kategoriler
        self.sanatciAlbumAdi = sanatciAlbumAdi
        self.sanatciResimAdi = sanatciResimAdi
        self.cikisTarihi = cikisTarihi
        
    }
    
}

