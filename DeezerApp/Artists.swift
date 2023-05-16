//
//  Sanatcilar.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import Foundation

class Artists:Codable {
    var data: [Category]?
}
    class Artist:Codable {
    
        var id:Int?
        var name:String?
        var picture:String?
        var picture_small:String?
        var picture_medium:String?
        var picture_big:String?
        var picture_xl:String?
        var radio:Bool?
        var tracklist:String?
        var type:String?
    
    // İlgili api: https://api.deezer.com/genre/{genre_id}/artists
    
    init() {
        
    }
    init(id:Int,name:String,picture:String,picture_small:String,picture_medium:String,picture_big:String,picture_xl:String,radio:Bool,tracklist:String,type:String) {
        
        self.id = id
        self.name = name
        self.picture = picture
        self.picture_small = picture_small
        self.picture_medium = picture_medium
        self.picture_big = picture_big
        self.picture_xl = picture_xl
        self.radio = radio
        self.tracklist = tracklist
        self.type = type
    }
    
    
}

