//
//  ThirdViewController.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import UIKit

class ThirdViewController: UIViewController {

    
    var albumListesi = [sanatciAlbumleri]()
    var sanatci:Category?

    @IBOutlet weak var albumDetay: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let genislik = self.albumDetay.frame.size.width
            tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            tasarim.minimumLineSpacing = 10
            tasarim.minimumInteritemSpacing = 10
            let hucregenislik = (genislik-30)/2
            tasarim.itemSize = CGSize(width: hucregenislik, height: hucregenislik*1.15)
            albumDetay.collectionViewLayout = tasarim
       
        albumDetay.delegate = self
        albumDetay.dataSource = self
    
        if let k = sanatci {
            if let kid = k.id {
                
                navigationItem.title = k.name
                sanatciAlbumleriByKategoriID(id: kid)
                
            }
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! FourthViewController
        gidilecekVC.kategori = [indeks!] as! Category?
        
    }
    
    func sanatciAlbumleriByKategoriID(id:Int){
        var request = URLRequest(url: URL(string: "https://api.deezer.com/artist/artist_id")!)
        request.httpMethod = "POST"
        let postString = "id = \(id)"
        request.httpBody = postString.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) {data , response , error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do {
            let cevap = try JSONDecoder().decode(sanatciAdiveAlbumCevap.self, from: data!)
                if let gelenAlbumListesi = cevap.albumlercevap{
                    self.albumListesi = gelenAlbumListesi
                }
                DispatchQueue.main.async {
                    self.albumDetay.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    
    }
extension ThirdViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albumListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sanatciAdiVeAlbumHucre", for: indexPath) as! SanatciAdiVeAlbumCollectionViewCell
        

        cell.albumGorseliImageView.image = UIImage(named: album.sanatciResimAdi! )
        cell.albumIsmiLabel.text = album.sanatciAlbumAdi
        cell.cikisTarihiLabel.text = album.cikisTarihi
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albumListesi[indexPath.row]
        print("\(album.sanatciAlbumAdi!) kişisi seçildi.")
        self.performSegue(withIdentifier: "toAlbumAdı", sender: indexPath.row)
        
    }
    
    
    
}
