//
//  IngresoViewController.swift
//  oficinas_casas
//
//  Created by Ventura on 23/09/2023.
//

import UIKit

class IngresoViewController: UIViewController {
    
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnIniciar(_ sender: Any) {
        let email = txtCorreo.text
        let pass = txtContrasena.text
        
        if let emailAt = email, let passAt = pass {
            if !emailAt.isEmpty, !passAt.isEmpty {
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
