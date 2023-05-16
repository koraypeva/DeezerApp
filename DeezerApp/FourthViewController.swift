//
//  FourthViewController.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var albumDetayCell: UICollectionView!
    
    var albumAdiVeSarkiListesi = [albumdekiSarkilar]()
    
    var kategori:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let genislik = self.albumDetayCell.frame.size.width
            tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            tasarim.minimumLineSpacing = 10
            tasarim.minimumInteritemSpacing = 10
            let hucregenislik = (genislik-30)/2
            tasarim.itemSize = CGSize(width: hucregenislik, height: hucregenislik*1.15)
            albumDetayCell.collectionViewLayout = tasarim
            
        albumDetayCell.delegate = self
        albumDetayCell.dataSource = self
        
     if let k = kategori {
        if let kid = k.id {
                
                navigationItem.title = k.name
                albumdekiSarkilarByKategoriID(id: kid)
                
            }
        }
        // Do any additional setup after loading the view.
    }
    func albumdekiSarkilarByKategoriID(id:Int){
        var request = URLRequest(url: URL(string: "https://api.deezer.com/album/album_id")!)
        request.httpMethod = "POST"
        let postString = "id = \(id)"
        request.httpBody = postString.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) {data , response , error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do {
            let cevap = try JSONDecoder().decode(albumdekiSarkilar.self, from: data!)
                if let gelenAlbumListesi = cevap.albumSarkilarCevap{
                    self.albumAdiVeSarkiListesi = gelenAlbumListesi
                }
                DispatchQueue.main.async {
                    self.albumDetayCell.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    


}
extension FourthViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return albumAdiVeSarkiListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sarki = albumAdiVeSarkiListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumAdiVeSarkiHucre", for: indexPath) as! AlbumAdiveSarkiCollectionViewCell
        
        cell.sarkiGorseli.image = UIImage(named: sarki.albumResimAdi! )
        cell.sarkiSaniye.text = sarki.albumSarkisaniye
        cell.sarkiAdiLabel.text = sarki.albumSarkiAdi
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumAdıVeSarki = albumAdiVeSarkiListesi[indexPath.row]
        print("\(albumAdıVeSarki.albumSarkiAdi!) şarkısı seçildi.")
    }
}
