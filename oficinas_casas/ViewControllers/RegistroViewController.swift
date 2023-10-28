//
//  RegistroViewController.swift
//  oficinas_casas
//
//  Created by Ventura on 23/09/2023.
//

import UIKit

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegistrarse(_ sender: Any) {
        let name = txtNombre.text
        let email = txtCorreo.text
        let pass = txtContrasena.text
        
        if let nameAt = name, let emailAt = email, let passAt = pass {
            if !nameAt.isEmpty, !emailAt.isEmpty, !passAt.isEmpty {
                goToMain()
            } else {
                showAlert()
            }
        } else {
            // Error
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
