//
//  PerfilViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 1/10/23.
//

import UIKit

class PerfilViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var perfilTableView: UITableView!
    
    var perfilList: [Perfil] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perfilTableView.dataSource = self
        perfilTableView.delegate = self
        
        perfilList.append(Perfil(enlace: "Informacion de Perfil"))
        perfilList.append(Perfil(enlace: "Informacion de pago"))
        perfilList.append(Perfil(enlace: "Historial de compras"))
        perfilList.append(Perfil(enlace: "Cerrar Sesion"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perfilList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemPerfil", for: indexPath) as! PerfilTableViewCell
        
        let perfil = perfilList[indexPath.row]
        
        cell.lblEnlace.text = perfil.enlace
        
        return cell
    }
}
