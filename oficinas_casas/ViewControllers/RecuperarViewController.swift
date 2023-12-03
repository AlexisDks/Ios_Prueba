//
//  RecuperarViewController.swift
//  oficinas_casas
//
//  Created by Miller Espinoza on 12/11/23.
//

import UIKit
import Firebase

class RecuperarViewController: UIViewController {
    @IBOutlet weak var txtCorreo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnEnviar(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: txtCorreo.text!) {
            (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
