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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return perfilList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemPerfil", for: indexPath) as! PerfilTableViewCell
        
        let perfil = perfilList[indexPath.row]
        
        // cell.lblInformacion.text = perfil.dato_Lista
        
        return cell
    }
}
