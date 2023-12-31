//
//  PrincipalViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 30/09/23.
//

import UIKit
import Firebase
import Kingfisher

class PrincipalViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var tblPrincipal: UICollectionView!
    
    var productList: [Producto] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPrincipal.dataSource = self
        tblPrincipal.delegate = self
        self.listarProductos()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(5, productList.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let producto = productList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemPrincipal", for: indexPath) as! PrincipalCollectionViewCell
        
        if let url = URL(string: producto.imagen) {
                cell.uiImg.kf.setImage(with: url)
        }
        
        cell.lblNombre.text = producto.nombre
        cell.lblPrcio.text = "$ " + String(producto.precio)
        
        return cell
    }
    

}

extension PrincipalViewController {
    func listarProductos() {
        let db = Firestore.firestore()
        
        db.collection("productos").getDocuments(completion: { (query, error) in
            if let error = error {
                print(error)
            } else {
                if let query = query {
                    for document in query.documents {
                        let data = document.data()
                        let nombre = data["nombre"] as? String ?? ""
                        let precio = data["precio"] as? Double ?? 0
                        let imagen = data["imagen"] as? String ?? ""
                        let cantidad = data["cantidad"] as? Int ?? 0
                        let descripcion = data["descripcion"] as? String ?? ""
                        let idcategoria = data["idcategoria"] as? String ?? ""
                        
                        let categoria = Producto(nombre: nombre, precio: precio, cantidad: cantidad, descripcion: descripcion, idcategoria: idcategoria, imagen: imagen)
                        self.productList.append(categoria)
                    }
                    self.tblPrincipal.reloadData()
                }
            }
        })
    }
}
