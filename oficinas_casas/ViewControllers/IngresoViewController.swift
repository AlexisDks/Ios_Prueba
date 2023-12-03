//
//  IngresoViewController.swift
//  oficinas_casas
//
//  Created by Ventura on 23/09/2023.
//

import UIKit
import Firebase

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
                self.obtenerInformacionCuenta(uid: uid)
            } else {
                self.showAlert()
            }
        }
    }
    
    func ingresoExistente(nombre: String, apellidos: String) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "login_status")
        defaults.set(nombre, forKey: "login_nombre")
        defaults.set(apellidos, forKey: "login_apellidos")
        
    }
    
    func obtenerInformacionCuenta(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("usuarios").document(uid)
        docRef.getDocument(completion: { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let nombre = data?["nombre"] as? String ?? ""
                let apellidos = data?["apellidos"] as? String ?? ""
                
                self.ingresoExistente(nombre: nombre, apellidos: apellidos)
                self.goToMain()
            }
        })
    }
}
