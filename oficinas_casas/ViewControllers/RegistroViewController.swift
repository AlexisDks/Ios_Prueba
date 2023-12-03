//
//  RegistroViewController.swift
//  oficinas_casas
//
//  Created by Ventura on 23/09/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistroViewController: UIViewController {
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnRegistrarse(_ sender: Any) {
        let name = txtNombre.text!
        let email = txtCorreo.text!
        let pass = txtContrasena.text!
        
        self.registroFirebase(name: name, email: email, password: pass)
    }
}

extension RegistroViewController {
    func registroFirebase(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let user = result {
                let uid = user.user.uid
                self.registroUsuarioFirestore(name: name, email: email, uid: uid)
            } else {
                self.showAlert()
            }
        }
    }
    
    func registroUsuarioFirestore(name: String, email: String, uid: String) {
        let db = Firestore.firestore()
        db.collection("usuarios").document(uid).setData([
            "nombre": name,
            "correo": email,
            "apellidos": "",
            "telefono": 0
        ]) { error in
            if let err = error {
                print("Se presento error con usuarios")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
