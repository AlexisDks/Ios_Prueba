//
//  CategoriaViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 2/12/23.
//

import UIKit
import Firebase

class CategoriaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var tblCategoria: UICollectionView!
    
    var categoriaList: [Categoria] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCategoria.dataSource = self
        tblCategoria.delegate = self
        
        self.listarCategoria()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoria = categoriaList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoriaCollectionViewCell
        
        cell.lblCategoria.text = categoria.nombre
        
        return cell
    }
}

extension CategoriaViewController {
    func listarCategoria() {
        let db = Firestore.firestore()
        
        db.collection("categorias").getDocuments(completion: { (query, error) in
            if let error = error {
                print(error)
            } else {
                if let query = query {
                    for document in query.documents {
                        let data = document.data()
                        let nombre = data["nombre"] as? String ?? ""
                        
                        let categoria = Categoria(nombre: nombre)
                        self.categoriaList.append(categoria)
                    }
                    self.tblCategoria.reloadData()
                }
            }
        })
    }
}
