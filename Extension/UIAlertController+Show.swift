import UIKit

extension UIAlertController {
    
    static func showMessage(_ message: String) {
        showAlert(title: "", message: message, actions: [UIAlertAction(title: "확인", style: .cancel, handler: nil)])
    }
    
    static func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                alert.addAction(action)
            }
            guard let topViewController = UIApplication.topViewController() else {return}
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
}

/*
    UIAlertController.showMessage(error.localizedDescription)
*/
