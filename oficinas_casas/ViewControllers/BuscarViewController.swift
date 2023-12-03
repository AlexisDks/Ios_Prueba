//
//  BuscarViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 1/10/23.
//

import UIKit
import Firebase
import Kingfisher

class BuscarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tblBusqueda: UITableView!
    @IBOutlet weak var txtSearch: UISearchBar!
    
    var busquedaList: [Producto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblBusqueda.dataSource = self
        txtSearch.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busquedaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busqueda = busquedaList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemBusqueda", for: indexPath) as! BuscarTableViewCell
        
        if let url = URL(string: busqueda.imagen) {
                cell.imgProducto.kf.setImage(with: url)
        }
        
        cell.lblNombre.text = busqueda.nombre
        cell.lblPrecio.text = String(busqueda.precio)
        return cell
    }
}

extension BuscarViewController {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        txtSearch.resignFirstResponder()
        guard let buscar = txtSearch.text else { return }
        self.buscarProductos(criterio: buscar)
    }
}

extension BuscarViewController {
    func buscarProductos(criterio: String) {
            let db = Firestore.firestore()
            
            db.collection("productos")
                .whereField("nombre", isEqualTo: criterio)
                .getDocuments { [weak self] (querySnapshot, error) in
                    guard let self = self else { return }
                    
                    if let error = error {
                        print("Error al buscar productos: \(error.localizedDescription)")
                        return
                    }
                    
                    if let snapshot = querySnapshot {
                        self.busquedaList.removeAll()
                        
                        for document in snapshot.documents {
                            let data = document.data()
                            if let nombre = data["nombre"] as? String,
                               let precio = data["precio"] as? Double,
                               let imagen = data["imagen"] as? String,
                               let cantidad = data["cantidad"] as? Int,
                               let idcategoria = data["idcategoria"] as? String,
                               let descripcion = data["descripcion"] as? String {
                                let producto = Producto(nombre: nombre, precio: precio, cantidad: cantidad, descripcion: descripcion, idcategoria: idcategoria, imagen: imagen)
                                self.busquedaList.append(producto)
                            }
                        }
                        self.tblBusqueda.reloadData()
                    }
            }
        }
}
