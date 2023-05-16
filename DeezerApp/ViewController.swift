//
//  ViewController.swift
//  DeezerApp
//
//  Created by Koray Şahin on 9.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    
    var kategorilerListesi = [Category]()
    
    // İlgili api: https://api.deezer.com/genre
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tumKategorileriAl()
        
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.kategoriCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 10
        tasarim.minimumInteritemSpacing = 10
        let hucregenislik = (genislik-30)/2
        tasarim.itemSize = CGSize(width: hucregenislik, height: hucregenislik*1.15)
        kategoriCollectionView.collectionViewLayout = tasarim
        
        kategoriCollectionView.delegate = self
        kategoriCollectionView.dataSource = self
        
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! SecondViewController
        gidilecekVC.kategori = kategorilerListesi[indeks!]
        
    }
    
    func tumKategorileriAl(){
         let url = URL(string: "https://api.deezer.com/genre")!
        URLSession.shared.dataTask(with: url) {data , response , error in
            if error != nil || data == nil {
                print("Hata")
                return
            }
            do {
            let cevap = try JSONDecoder().decode(kategoriCevap.self, from: data!)
              if let gelenKategorilistesi = cevap.kategoriler {
                self.kategorilerListesi = gelenKategorilistesi
                }
                DispatchQueue.main.async {
                    self.kategoriCollectionView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

}


extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        kategorilerListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let kategori = kategorilerListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kategorilerHucre", for: indexPath) as! KategorilerCollectionViewCell
        cell.kategoriAdıLabel.text = kategori.name!
        cell.kategoriImageView.image = UIImage(named: kategori.picture!)
       
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kategori = kategorilerListesi[indexPath.row]
        print("\(kategori.name!) kategorisi seçildi.")
        self.performSegue(withIdentifier: "toKategoriAdi", sender: indexPath.row)
    }
    
}

