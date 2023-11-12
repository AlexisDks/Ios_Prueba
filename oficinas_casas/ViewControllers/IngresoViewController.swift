//
//  IngresoViewController.swift
//  oficinas_casas
//
//  Created by Ventura on 23/09/2023.
//

import UIKit
import FirebaseAuth

class IngresoViewController: UIViewController {
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnIniciar(_ sender: Any) {
        let email = txtCorreo.text
        let pass = txtContrasena.text
        
        if let emailAt = email, let passAt = pass {
            if !emailAt.isEmpty, !passAt.isEmpty {
                self.ingresoFirebase(email: emailAt, password: passAt)
            } else {
                showAlert()
            }
        } else {
            // Error
        }
    }
    
    @IBAction func btnRecuperarClave(_ sender: Any) {
        goToRec()
    }
}

extension IngresoViewController {
    func ingresoFirebase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let user = result {
                let uid = user.user.uid
                self.ingresoExistente()
                self.goToMain()
            } else {
                self.showAlert()
            }
        }
    }
    
    func ingresoExistente() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "login_status")
    }
}
