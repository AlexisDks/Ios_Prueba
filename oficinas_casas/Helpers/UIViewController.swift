import UIKit

extension UIViewController {
    
    func goToMain() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Principal", bundle: nil)
        let ingresoScreen = storyBoard.instantiateViewController(withIdentifier: "HogarViewController") as! HogarViewController
        ingresoScreen.modalPresentationStyle = .fullScreen
        self.present(ingresoScreen, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Verifique sus datos.", preferredStyle: .alert)
        let btnEntendido = UIAlertAction(title: "Entendido", style: .default)
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(btnEntendido)
        alert.addAction(btnCancelar)
        self.present(alert, animated: true)
    }
}
