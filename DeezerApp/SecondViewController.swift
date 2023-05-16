//
//  SecondViewController.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
     var sanatciListesi = [Artist]()
    
    var kategori:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.sanatciDetay.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 10
        tasarim.minimumInteritemSpacing = 10
        let hucregenislik = (genislik-30)/2
        tasarim.itemSize = CGSize(width: hucregenislik, height: hucregenislik*1.15)
        sanatciDetay.collectionViewLayout = tasarim
      
        sanatciDetay.delegate = self
        sanatciDetay.dataSource = self
        
        // İlgili api: https://api.deezer.com/genre/{genre_id}/artists
        
        if let k = kategori {
            if let kid = k.id {
                navigationItem.title = k.name
                sanatcilarByKategoriID(id: kid)
            }
        }
    }
    @IBOutlet weak var sanatciDetay: UICollectionView!
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let indeks = sender as? Int
        let gidilecekVC = segue.destination as! ThirdViewController
        gidilecekVC.sanatci = sanatciListesi[indeks!] as! Category?
        
    }
    
    func sanatcilarByKategoriID(id:Int){
        var request = URLRequest(url: URL(string: "https://api.deezer.com/genre/{genre_id}/artists")!)
        request.httpMethod = "POST"
        let postString = "id = \(id)"
        request.httpBody = postString.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) {data , response , error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do {
            let cevap = try JSONDecoder().decode(sanatciCevap.self, from: data!)
                if let gelenSanatcilistesi = cevap.sanatcilarcevap {
                    self.sanatciListesi = gelenSanatcilistesi
                }
                DispatchQueue.main.async {
                    self.sanatciDetay.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    
}
extension SecondViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sanatciListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sanatci = sanatciListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sanatcilarHucre", for: indexPath) as! SanatcilarCollectionViewCell
        
        if let url = URL(string: "https://api.deezer.com/genre/image/\(sanatci.picture!)"){
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                cell.sanatciAdiImage.image = UIImage(data: data!)
            }
        }
        
        
        cell.sanatciAdiImage.image = UIImage(named: sanatci.picture!)
        cell.sanatciAdiLabel.text = sanatci.name
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sanatci = sanatciListesi[indexPath.row]
        print("\(sanatci.id!) kişisi seçildi.")
        self.performSegue(withIdentifier: "toSanatcıAdı", sender: indexPath.row)
        
    }
    
    
}
