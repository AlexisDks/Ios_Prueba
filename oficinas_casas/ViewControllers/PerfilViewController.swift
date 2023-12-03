//
//  PerfilViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 1/10/23.
//

import UIKit

class PerfilViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var perfilTableView: UITableView!
    @IBOutlet weak var lblNombre: UILabel!
    
    var perfilList: [Perfil] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perfilTableView.dataSource = self
        perfilTableView.delegate = self
        
        if let nombre = UserDefaults.standard.string(forKey: "login_nombre"),
           let apellidos = UserDefaults.standard.string(forKey: "login_apellidos") {
            lblNombre.text = nombre + " " + apellidos
        } else {
            lblNombre.text = "Usuario Generico"
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                let alert = UIAlertController(title: "Primera celda", message: "Se seleccionó la primera celda.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            case 1:
                break
            case 3:
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                self.goToIndex()
                break
            default:
                break
            }
    }
}
