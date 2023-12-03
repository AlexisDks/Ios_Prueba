//
//  ProductosViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 3/12/23.
//

import UIKit
import Firebase
import Kingfisher

class ProductosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var tblProductos: UICollectionView!
    
    var productList: [Producto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblProductos.dataSource = self
        tblProductos.delegate = self
        self.listarProductos()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let producto = productList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemProductos", for: indexPath) as! ProductosCollectionViewCell
        
        if let url = URL(string: producto.imagen) {
                cell.imgProducto.kf.setImage(with: url)
        }
        
        cell.lblNombre.text = producto.nombre
        cell.lblPrecio.text = "$ " + String(producto.precio)
        
        return cell
    }
}

extension ProductosViewController {
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
                    self.tblProductos.reloadData()
                }
            }
        })
    }
}
